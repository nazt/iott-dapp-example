// SPDX-License-Identifier: MIT

contract DeviceOracle {
    string public latitude;
    string public longitude;
    uint64 public value;

    // function get(uint256 i) public view returns (uint256) {
    //     return arr[i];
    // }
    //
    function setValue(uint64 val) public {
        value = val;
    }
}
