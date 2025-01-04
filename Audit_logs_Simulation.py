import json
import time
import random

# 生成模拟的审计日志
# Generate simulated audit logs
def generate_audit_logs(num_logs=10000):
    actions = ["UserLogin", "DataAccess", "ConfigurationChange", "FileDownload", "PermissionUpdate"]
    logs = []
    for i in range(num_logs):
        log = {
            "id": i,  # 日志的唯一标识符
                     # Unique identifier for the log
            "timestamp": int(time.time()) + i,  # 使用递增时间戳模拟日志生成时间
                                                # Simulate log generation time with incrementing timestamps
            "action": random.choice(actions),  # 随机选择一个操作类型
                                               # Randomly select an action type
            "user": f"user_{random.randint(1, 100)}",  # 模拟随机用户ID
                                                      # Simulate random user IDs
            "details": f"Simulated log entry {i}"  # 日志详细信息
                                                   # Detailed description of the log
        }
        logs.append(log)
    return logs

# 保存日志到文件
# Save logs to a file
def save_logs_to_file(logs, filename="audit_logs_large.json"):
    with open(filename, "w") as f:
        json.dump(logs, f, indent=4)  # 将日志数据保存为JSON格式
                                     # Save log data in JSON format

# 主程序
# Main program
if __name__ == "__main__":
    num_logs = 10000  # 生成的日志数量，可根据需要调整
                      # Number of logs to generate, adjust as needed
    logs = generate_audit_logs(num_logs)  # 调用日志生成函数
                                          # Call the log generation function
    save_logs_to_file(logs)  # 将生成的日志保存到文件中
                             # Save the generated logs to a file
    print(f"{num_logs} audit logs saved to audit_logs_large.json")  # 打印生成日志的数量
                                                                   # Print the number of generated logs
