// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {LayerSDK} from 'contracts/LayerSDK.sol';

contract LayerConsumer is LayerSDK {
  /// @notice Initializer
  constructor(address _stakeRegistry) LayerSDK(_stakeRegistry) {}

  /**
   * @notice Validates a layer task from off-chain AVS operator
   * @param _offchainData The off-chain data to verify
   * @return _isValid Whether the task is valid
   */
  function validateLayerTask(string calldata _offchainData) external view returns (bool _isValid) {
    Task memory _task = Task({dataHash: bytes32(bytes(_offchainData[0:32])), signatureData: bytes(_offchainData[32:])});
    _isValid = _validateLayerTask(_task);
  }
}
