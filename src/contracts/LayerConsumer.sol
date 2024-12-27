// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {LayerSDK} from 'contracts/LayerSDK.sol';
import {ILayerConsumer} from 'interfaces/ILayerConsumer.sol';

contract LayerConsumer is LayerSDK, ILayerConsumer {
  /// @notice Initializer
  constructor(address _stakeRegistry) LayerSDK(_stakeRegistry) {}

  /// @inheritdoc ILayerConsumer
  function validateLayerTask(string calldata _offchainData) external view returns (bool _isValid) {
    Task memory _task = Task({dataHash: bytes32(bytes(_offchainData[0:32])), signatureData: bytes(_offchainData[32:])});
    _isValid = _validateLayerTask(_task);
  }
}
