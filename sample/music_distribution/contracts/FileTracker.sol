pragma solidity ^0.4.18;

import "./FileStore.sol";
import "./Upgradable.sol";
import "./DataLibrary.sol";

contract FileTracker is Upgradable {

  modifier onlyFileCreator(uint fileId) {
    uint _fileId;
    bytes32 _filename;
    address _creator;
    uint _downloadPrice;
    uint _openPrice;
    bool _available;

    (_fileId, _filename, _creator, _downloadPrice, _openPrice, _available) = fileStore.getFile(fileId);
    DataLibrary.FileItem memory file = DataLibrary.FileItem(_fileId, _filename, _creator, _downloadPrice, _openPrice, _available);

    require(msg.sender == file.creator);
    _;
  }

  address owner;
  address fileStoreAddress;
  FileStore fileStore;

  function createFile(uint fileId, bytes32 filename, uint downloadPrice, uint openPrice) public {}

  function getFileIds() public constant returns(uint[100]) {}

  function removeFile(uint fileId) public onlyFileCreator(fileId) {}

  function downloadFile(uint fileId) public payable {}

  function openFile(uint fileId) public payable {}

}
