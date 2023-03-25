from fluent import event, sender

sender.setup("test", host="localhost", port=24224)
event.Event("forward", {"from": "userA", "to": "userB"})
