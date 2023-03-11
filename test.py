from fluent import event, sender

sender.setup("fluentd.test", host="localhost", port=24224)
event.Event("follow", {"from": "userA", "to": "userB"})
