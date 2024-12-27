// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {ILayerConsumer} from 'interfaces/ILayerConsumer.sol';

interface ILayerSDK is ILayerConsumer {
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
