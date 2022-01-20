// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

// import OpenZeppelin Ownable
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

import "./Oracle.sol";

contract Device is Ownable {
    Oracle public immutable oracle;
    uint256 public immutable idx;
    uint256 private exchangeRate;

    event UpdateData(address indexed sender, uint256 value);

    constructor(address addr, uint256 _idx) {
        oracle = Oracle(addr);
        idx = _idx;
    }

    function get() public view returns (uint256) {
        return oracle.get(idx);
    }

    function set(uint256 val) public onlyOwner {
        oracle.set(idx, val);
        emit UpdateData(msg.sender, val);
    }
}
