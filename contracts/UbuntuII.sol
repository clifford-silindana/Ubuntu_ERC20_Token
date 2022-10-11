//SPDX-License-Identifier: MIT
//USING OPENZEPPELIN

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UbuntuII is ERC20 {
    constructor() ERC20("UbuntuII", "UBUII") {
        _mint(msg.sender, 1000);
    }
}
