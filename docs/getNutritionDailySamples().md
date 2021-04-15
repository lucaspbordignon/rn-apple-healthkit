A quantity daily sample type that returns nutrition information for a given type.

```javascript
let d = new Date(2016, 1, 1);
let options = {
  startDate: new Date(2016, 10, 1).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  type: "EnergyConsumed", // ['Carbohydrates', 'FatTotal', 'Protein', ...] (see RCTAppleHealthKit+Methods_Dietary.m for full list)
};
```

```javascript
AppleHealthKit.getNutritionDailySamples(
  (options: Object),
  (err: Object, results: Object) => {
    if (err) {
      return;
    }
    console.log(results);
  }
);
```
