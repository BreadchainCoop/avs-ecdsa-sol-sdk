// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Script} from 'forge-std/Script.sol';
// solhint-disable-next-line
import 'script/Registry.sol';

/**
 * @title Common Contract
 * @author Breadchain
 */
contract Common is Script {
  function setUp() public virtual {}

  function _deployContracts() internal {}
}
