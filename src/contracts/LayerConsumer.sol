// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {ECDSAStakeRegistry} from '@eigenlayer-middleware/unaudited/ECDSAStakeRegistry.sol';
import {ILayerConsumer} from 'interfaces/ILayerConsumer.sol';

contract LayerConsumer is ILayerConsumer {
  /// @notice bytes4(keccak256("isValidSignature(bytes32,bytes)")
  bytes4 internal constant _ERC1271_SIGNATURE = 0x1626ba7e;

  /// @inheritdoc ILayerConsumer
  ECDSAStakeRegistry public immutable STAKE_REGISTRY;

  /// @notice Enforce that the caller is an operator
  modifier onlyOperator() {
    if (!STAKE_REGISTRY.operatorRegistered(msg.sender)) revert NotOperator();
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
}
