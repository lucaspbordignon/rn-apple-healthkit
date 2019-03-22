A quantity sample type that measures the amount of active energy the user has burned.

```javascript

let d = new Date(2016,1,1);
let options = {
  startDate: (new Date(2016,10,1)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default to false,
  limit: 10, // optional; default to no limit
  interval: 60, // optional; default to 60 minutes
  unit: 'kcal' // optional; one of 'kcal', 'J', or prefix with metric e.g., 'kJ'  default to 'kcal'
};

```

```javascript
AppleHealthKit.getActiveEnergyBurnedSamples(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
