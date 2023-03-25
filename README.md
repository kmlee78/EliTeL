# EliTeL

Use of several ETL tools using python

---

## 1. fluentd

### 1-1. Start

```
$ scripts/run.sh fluentd
```

### 1-2. Apply fluentd config

Get inside the shell and execute td-agent

```
$ scripts/restart_td_agent.sh
```

### 1-3. Test and see the result

```
$ python test.py
$ tail -n 1 /var/log/td-agent/td-agent.log
2023-03-25 07:51:13.000000000 +0000 test.forward: {"from":"userA","to":"userB"}
```
