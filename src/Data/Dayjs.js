const dayjs = require('dayjs');

exports.fromUnixTime = function(t) {
  return dayjs(t * 1000);
};

exports.toUnixTime = function(t) {
  return t.unix();
};

exports.set = function(string) {
  return function(int) {
    return function(t) {
      return t.set(string, int);
    };
  };
};

exports.add = function(num) {
  return function(units) {
    return function(t) {
      return t.add(num, units);
    };
  };
};

exports.subtract = function(num) {
  return function(units) {
    return function(t) {
      return t.subtract(Number(num), units);
    };
  };
};

exports.format = function(formatStr) {
  return function(t) {
    return t.format(formatStr);
  };
};

exports.getDayjs = function() {
  return dayjs();
};

exports.dayjs = dayjs;

exports.extend = function(plugin) {
  return function(option) {
    return function() {
      return dayjs.extend(function(a, b, c) {
        plugin(a, b, c)();
      }, option);
    }
  }
}

exports.isValid = function(t) {
  return t.isValid();
}

exports.isLeapYear = function(t) {
  return t.isLeapYear();
}

exports.isSame = function(t) {
  return function(t1) {
    return t1.isSame(t);
  }
}

exports.isBefore = function(t) {
  return function(t1) {
    return t1.isBefore(t);
  }
}

exports.isAfter = function(t) {
  return function(t1) {
    return t1.isAfter(t);
  }
}

exports.year = function(t) {
  return t.year();
}

exports.month = function(t) {
  return t.month();
}

exports.day = function(t) {
  return t.day();
}

exports.date = function(t) {
  return t.date();
}

exports.hour = function(t) {
  return t.hour();
}

exports.minute = function(t) {
  return t.minute();
}

exports.second = function(t) {
  return t.second();
}

exports.millisecond = function(t) {
  return t.millisecond();
}
