// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {ECDSAStakeRegistry} from '@eigenlayer-middleware/unaudited/ECDSAStakeRegistry.sol';

/**
 * @title LayerSDK Contract
 * @author Breadchain
 * @notice LayerSDK contract to validate layer tasks from off-chain AVS operators
 */
interface ILayerSDK {
  /*///////////////////////////////////////////////////////////////
                            DATA STRUCTURES
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice The task structure
   * @param dataHash The hash of the data to verify
   * @param signatureData The signature(s) to verify
   */
  struct Task {
    bytes32 dataHash;
    bytes signatureData;
  }

  /*///////////////////////////////////////////////////////////////
                            ERRORS
  //////////////////////////////////////////////////////////////*/

  /// @notice Error thrown when the caller is not an operator
  error NotOperator();

  /*///////////////////////////////////////////////////////////////
                            VARIABLES
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice The stake registry contract
   * @return _stakeRegistry The stake registry address
   */
  function STAKE_REGISTRY() external view returns (ECDSAStakeRegistry _stakeRegistry); // solhint-disable-line func-name-mixedcase
}
