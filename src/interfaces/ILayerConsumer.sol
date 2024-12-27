// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {ILayerSDK} from 'interfaces/ILayerSDK.sol';

interface ILayerConsumer is ILayerSDK {
  /*///////////////////////////////////////////////////////////////
                            LOGIC
  //////////////////////////////////////////////////////////////*/

  /**
   * @notice Validates a layer task from off-chain AVS operator
   * @param _offchainData The off-chain data to verify
   * @return _isValid Whether the task is valid
   */
  function validateLayerTask(string calldata _offchainData) external view returns (bool _isValid);
}
