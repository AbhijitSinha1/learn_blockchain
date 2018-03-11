pragma solidity ^0.4.18;

import "./FileTracker.sol";
import "./DataLibrary.sol";

contract MusicFileTracker is FileTracker {

  function createFileStore() public onlyOwner {
    fileStore = new FileStore();
    // fileStoreAddress = fileStore.address;
  }

  function setFileStore(address _fileStoreAddress) public onlyOwner {
    fileStoreAddress = _fileStoreAddress;
    fileStore = FileStore(_fileStoreAddress);
  }

  function createFile(uint fileId, bytes32 filename, uint downloadPrice, uint openPrice) public {
    fileStore.addFile(fileId, filename, msg.sender, downloadPrice, openPrice);
  }

  function removeFile(uint fileId) public onlyFileCreator(fileId) {
    fileStore.removeFile(fileId);
  }

  function getFileIds() public constant returns(uint[100]) {
    return fileStore.getFileIds();
  }

  function downloadFile(uint fileId) public payable {
    uint _fileId;
    bytes32 _filename;
    address _creator;
    uint _downloadPrice;
    uint _openPrice;
    bool _available;

    (_fileId, _filename, _creator, _downloadPrice, _openPrice, _available) = fileStore.getFile(fileId);

    DataLibrary.FileItem memory file = DataLibrary.FileItem(_fileId, _filename, _creator, _downloadPrice, _openPrice, _available);

    if(file.fileId == 0) {
      revert();
    }
    if(!file.available) {
      revert();
    }
    address creator = file.creator;
    uint price = file.downloadPrice;

    creator.transfer(price);
  }

  function openFile(uint fileId) public payable {
    uint _fileId;
    bytes32 _filename;
    address _creator;
    uint _downloadPrice;
    uint _openPrice;
    bool _available;

    (_fileId, _filename, _creator, _downloadPrice, _openPrice, _available) = fileStore.getFile(fileId);

    DataLibrary.FileItem memory file = DataLibrary.FileItem(_fileId, _filename, _creator, _downloadPrice, _openPrice, _available);
    if(file.fileId == 0) {
      revert();
    }
    if(!file.available) {
      revert();
    }
    address creator = file.creator;
    uint price = file.openPrice;

    creator.transfer(price);
  }

  function getFileInfo(uint fileId) public constant returns (bytes32, uint, uint) {
    uint _fileId;
    bytes32 _filename;
    address _creator;
    uint _downloadPrice;
    uint _openPrice;
    bool _available;

    (_fileId, _filename, _creator, _downloadPrice, _openPrice, _available) = fileStore.getFile(fileId);

    DataLibrary.FileItem memory file = DataLibrary.FileItem(_fileId, _filename, _creator, _downloadPrice, _openPrice, _available);
    if(file.fileId == 0) {
      revert();
    }
    if(!file.available) {
      revert();
    }

    return (_filename, _downloadPrice, _openPrice);
  }
}
