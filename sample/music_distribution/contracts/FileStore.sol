pragma solidity ^0.4.18;

import "./helper_contracts/zeppelin/lifecycle/Killable.sol";
import "./DataLibrary.sol";

contract FileStore is Killable {

  mapping(uint => DataLibrary.FileItem) files;
  uint[100] fileIds;
  uint8 i = 0;

  function addFile(uint _fileId, bytes32 _filename, address _creator, uint _downloadPrice, uint _openPrice) public {
    DataLibrary.FileItem storage file = files[_fileId];
    file.fileId = _fileId;
    file.filename = _filename;
    file.creator = _creator;
    file.downloadPrice = _downloadPrice;
    file.openPrice = _openPrice;
    file.available = true;
    i++;
    fileIds[i] = _fileId;
  }

  function getFileIds() public constant returns(uint[100]) {
    return fileIds;
  }

  function removeFile(uint fileId) public {
    DataLibrary.FileItem memory file = files[fileId];
    if(file.fileId == 0) {
      revert();
    }
    file.available = false;
  }

  function getFile(uint _fileId) public returns (uint, bytes32, address, uint, uint, bool) {
    return (
      files[_fileId].fileId,
      files[_fileId].filename,
      files[_fileId].creator,
      files[_fileId].downloadPrice,
      files[_fileId].openPrice,
      files[_fileId].available
    );
  }

}
