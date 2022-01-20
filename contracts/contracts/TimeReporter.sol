// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TimeReporter {
    event TimeLog(uint256 time);

    function reportTime() public {
        for (uint8 i = 0; i < 10; i++) {
            emit TimeLog(block.timestamp);
        }
    }
}
