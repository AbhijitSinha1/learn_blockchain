pragma solidity ^0.4.18;

library DataLibrary {
  struct FileItem {
    uint fileId;
    bytes32 filename;
    address creator;
    uint downloadPrice;
    uint openPrice;
    bool available;
  }
}
