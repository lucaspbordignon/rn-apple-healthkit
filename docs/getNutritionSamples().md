```javascript
let options = {
  startDate: new Date(2019, 06, 21).toISOString(), // required
  type: 'Calcium', // see Constants/NutritionIntakes.js for all the options
  endDate: new Date().toISOString(), // optional; default now
  unit: 'gram' // optional; default 'gram',
  
};
```

```javascript
AppleHealthKit.getNutritionSamples(options: Object, (error: Object, results: Object) => {
    if (error) {
      console.error(error.message);
    }
    console.log(results);
});
```
