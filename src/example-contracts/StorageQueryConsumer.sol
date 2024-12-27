// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {LayerSDK} from 'contracts/LayerSDK.sol';

contract StorageQueryConsumer is LayerSDK {
  /// @notice Mapping to store the task hashes
  mapping(bytes32 _taskHash => bool _isValid) internal _storedTasks;

  /// @notice Initializer
  constructor(address _stakeRegistry) LayerSDK(_stakeRegistry) {}

  /**
   * @notice Stores a layer task
   * @param _task The task to store
   */
  function storeLayerTask(Task memory _task) external onlyValidLayerTask(_task) {
    _storedTasks[_task.dataHash] = true;
  }

  /**
   * @notice Queries a layer task
   * @param _taskHash The hash of the task to query
   * @return _isValid Whether the task is valid
   */
  function queryLayerTask(bytes32 _taskHash) external view returns (bool _isValid) {
    _isValid = _storedTasks[_taskHash];
  }
}
