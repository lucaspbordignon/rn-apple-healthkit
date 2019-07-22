```javascript
let options = {
  startDate: new Date(2019, 06, 21).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  unit: 'gram' // optional; default 'gram'
};
```

```javascript
AppleHealthKit.getCalciumSamples(options: Object, (error: Object, results: Object) => {
    if (error) {
      console.error(error.message);
    }
    console.log(results);
});
```
