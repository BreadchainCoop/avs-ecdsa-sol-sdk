// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {LayerSDK} from 'contracts/LayerSDK.sol';

contract OffchainMessageConsumer is LayerSDK {
  /// @notice The expected content of the offchain message
  string private constant _MESSAGE = 'Hello, World!';

  /// @notice Initializer
  constructor(address _stakeRegistry) LayerSDK(_stakeRegistry) {}

  /**
   * @notice Validates a layer task from off-chain AVS operator and checks the message
   * @param _task The off-chain message to verify and the encoded signature, signers and reference block
   * @return _isValid Whether the task is valid and the message is valid
   */
  function validateOffchainMessage(Task calldata _task) external view onlyValidLayerTask(_task) returns (bool _isValid) {
    _isValid = _validateEthSignedMessage(_task.dataHash, _MESSAGE);
  }
}
