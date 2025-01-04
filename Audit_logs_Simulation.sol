// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 合约：合规审计合约
contract ComplianceAudit {

    // 存储审计数据的结构
    struct AuditRecord {
        uint256 timestamp;  // 审计数据记录的时间戳
        string dataHash;    // 数据的哈希值
        address auditor;    // 审计员地址
        bool isVerified;    // 数据是否已通过验证
    }

    // 存储所有审计记录的数组
    AuditRecord[] public auditRecords;

    // 事件：记录审计结果
    event AuditRecorded(
        uint256 timestamp,
        string dataHash,
        address indexed auditor,
        bool isVerified
    );

    // 函数：记录审计数据
    function recordAudit(string memory _dataHash) public {
        // 创建新的审计记录
        AuditRecord memory newRecord = AuditRecord({
            timestamp: block.timestamp,
            dataHash: _dataHash,
            auditor: msg.sender,
            isVerified: false
        });

        // 将记录添加到存储的审计记录中
        auditRecords.push(newRecord);

        // 触发事件，记录审计
        emit AuditRecorded(block.timestamp, _dataHash, msg.sender, false);
    }

    // 函数：验证审计数据
    function verifyAudit(uint256 _auditId) public {
        require(_auditId < auditRecords.length, "Invalid audit ID.");

        // 获取审计记录
        AuditRecord storage record = auditRecords[_auditId];
  
        // 确保只有审计员可以验证数据
        require(msg.sender == record.auditor, "Only the auditor can verify this record.");

        // 标记数据为已验证
        record.isVerified = true;

        // 触发事件，记录验证结果
        emit AuditRecorded(record.timestamp, record.dataHash, record.auditor, true);
    }

    // 函数：获取审计记录数量
    function getAuditCount() public view returns (uint256) {
        return auditRecords.length;
    }

    // 函数：获取特定审计记录
    function getAuditRecord(uint256 _auditId) public view returns (uint256, string memory, address, bool) {
        require(_auditId < auditRecords.length, "Invalid audit ID.");
        AuditRecord memory record = auditRecords[_auditId];
        return (record.timestamp, record.dataHash, record.auditor, record.isVerified);
    }
}
