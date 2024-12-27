// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {LayerConsumer} from 'contracts/LayerConsumer.sol';
import {ILayerSDK} from 'interfaces/ILayerSDK.sol';

contract LayerSDK is LayerConsumer, ILayerSDK {
  /// @notice Initializer
  constructor(address _stakeRegistry) LayerConsumer(_stakeRegistry) {}

  /// @inheritdoc ILayerSDK
  function validateLayerTask(string calldata _offchainData) external view onlyOperator returns (bool _isValid) {
    Task memory _task = Task({dataHash: bytes32(bytes(_offchainData[0:32])), signatureData: bytes(_offchainData[32:])});
    _isValid = _validateLayerTask(_task);
  }
}
