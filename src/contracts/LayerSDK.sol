// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {ECDSAStakeRegistry} from '@eigenlayer-middleware/unaudited/ECDSAStakeRegistry.sol';
import {MessageHashUtils} from '@oz/utils/cryptography/MessageHashUtils.sol';
import {ILayerSDK} from 'interfaces/ILayerSDK.sol';

contract LayerSDK is ILayerSDK {
  using MessageHashUtils for bytes32;

  /// @notice bytes4(keccak256("isValidSignature(bytes32,bytes)")
  bytes4 internal constant _ERC1271_SIGNATURE = 0x1626ba7e;

  /// @inheritdoc ILayerSDK
  ECDSAStakeRegistry public immutable STAKE_REGISTRY;

  /**
   * @notice Modifier to ensure a task is valid
   * @param _task The task to validate
   */
  modifier onlyValidLayerTask(Task memory _task) {
    if (!_validateLayerTask(_task)) revert InvalidLayerTask();
    _;
  }

  /**
   * @notice Initializer
   * @param _stakeRegistry The address of the stake registry contract
   */
  constructor(address _stakeRegistry) {
    STAKE_REGISTRY = ECDSAStakeRegistry(_stakeRegistry);
  }

  /**
   * @notice Validates a layer task from off-chain AVS operator
   * @param _task The message and signatures to verify
   * @return _isValid Whether the task is valid
   */
  function _validateLayerTask(Task memory _task) internal view returns (bool _isValid) {
    _isValid = (_ERC1271_SIGNATURE == STAKE_REGISTRY.isValidSignature(_task.dataHash, _task.signatureData));
  }

  /**
   * @notice Validates the format of an EIP-712 signed message
   * @param _messageHash The hash of the message
   * @param _message The message to verify is hashed according to EIP-712
   * @return _isValid Whether the message hash represents the message according to EIP-712
   */
  function _validateEthSignedMessage(
    bytes32 _messageHash,
    string memory _message
  ) internal pure returns (bool _isValid) {
    bytes32 _msgToHash = keccak256(abi.encodePacked(_message));
    _isValid = _messageHash == _msgToHash.toEthSignedMessageHash();
  }
}
