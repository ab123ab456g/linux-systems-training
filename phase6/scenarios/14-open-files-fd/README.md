# 確認 open files / FD 使用量

## 目的
找 FD leak / limit

## 操作原則
- 先建立或讀取 baseline
- measure
- isolate
- 必要時 tune
- 用相同 workload verify
- monitor
- 若結果變差則 rollback

## 學生交付
- measurement evidence
- bottleneck conclusion
- before/after result
- rollback result（若有）
- final note
