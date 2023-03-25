import logging
import logging.config
import sys

LOGGING_CONFIG = dict(
    version=1,
    loggers={
        "ELITEL": {
            "level": "INFO",
            "handlers": ["console", "file_handler"],
            "propagte": "no",
        },
    },
    handlers={
        "console": {
            "class": "logging.StreamHandler",
            "level": "INFO",
            "formatter": "msg",
            "stream": sys.stdout,
        },
        "file_handler": {
            "class": "logging.FileHandler",
            "level": "WARNING",
            "formatter": "msg",
            "filename": "logs/warning.log",
        },
    },
    formatters={
        "msg": {
            "class": "logging.Formatter",
            "format": " %(levelname)s:%(created)s:%(message)s",
        }
    },
)

logging.config.dictConfig(LOGGING_CONFIG)
logger = logging.getLogger("ELITEL")
