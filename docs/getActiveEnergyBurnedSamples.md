A quantity sample type that measures the amount of active energy the user has burned.

```javascript
let options = {
  startDate: (new Date(2018,10,1)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default to false,
  limit: 10, // optional; default to no limit
  interval: 60, // optional; default to 60 minutes
  unit: 'kilocalorie' // optional; e.g., 'calorie', 'kilocalorie', 'joule' default to 'kilocalorie'
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
