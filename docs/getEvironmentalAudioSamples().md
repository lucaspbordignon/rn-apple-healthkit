Query for environmental phone audio samples.

Each environmental audo sample represents a period of time with a startDate and an endDate.
[Healthkit Hearing](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/3081271-environmentalaudioexposure) reference documentation

The options object is used to setup a query to retrieve relevant samples.
The options must contain `startDate` and may also optionally include `endDate`
and `limit` options
```javascript
let options = {
  startDate: (new Date(2016,10,1)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  limit:10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects
with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthKit.getEnvironmentalAudioSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results).
});
```
