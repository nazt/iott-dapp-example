// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract HelloOracle is Ownable {
    uint64 public state;
    uint256 public totalDevice = 100;
    address public immutable deployer;

    mapping(address => uint256) devices;

    event StateChanged(address indexed sender, uint64 s);

    constructor(address _owner) {
        deployer = _owner;
        devices[_owner] = totalDevice;
    }

    function setState(uint64 _state) public {
        state = _state;
        emit StateChanged(msg.sender, state);
    }

    function getState() public view returns (uint64) {
        return state;
    }

    function setWith(address account, uint64 s) public {
        state = s;
        devices[account] = s;
        emit StateChanged(msg.sender, state);
    }

    function getWith(address account) public view returns (uint256) {
        return devices[account];
    }

    function stateOf(address account) external view returns (uint256) {
        return devices[account];
    }
}
