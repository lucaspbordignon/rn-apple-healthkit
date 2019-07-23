```javascript
let options = {
  ascending: true, // optional; default true
  endDate: new Date().toISOString(), // optional; default now
  startDate: new Date(2019, 06, 21).toISOString(), // required
  unit: 'celsius' // optional; default 'celsius'
};
```

```javascript
AppleHealthKit.getBasalBodyTemperatureSamples(options: Object, (error: Object, results: Object) => {
    if (error) {
      console.error(error.message);
    }
    console.log(results);
});
```
