Save a cycling distance sample.

A quantity sample type that measures the distance the user has moved by cycling during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the cycling occured.

`saveDistanceCycling` accepts an options object containing required *`unit: ['meter', 'inch', 'foot', 'yard', 'mile']`*, *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*.

if *`unit`* is not provided, the default *`mile`* will be used.

```javascript
// startDate and endDate are 90 minutes apart.
// this means the cycling occurred within those 90 minutes.
let options = {
  unit: "mile",
  value: 10,
  startDate: (new Date(2016,6,2,6,0,0)).toISOString(),
  endDate: (new Date(2016,6,2,7,30,0)).toISOString()
};
```

```javascript
AppleHealthKit.saveDistanceCycling(options, (err, res) => {
  if (err) {
    return;
  }
  // Cycling distance sample successfully saved.
});
```