save a Water value to Healthkit

`saveWater` accepts an options object containing a numeric Water value:
```javascript
let options = {
  date: (new Date(2016,4,27)).toISOString(), // required
  water: 2  // value in liter
}
```
```javascript
AppleHealthKit.saveWater(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // Water successfully saved
});
```
