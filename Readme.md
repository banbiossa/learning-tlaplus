Readmd.md

- code: https://github.com/tlaplus/Examples/tree/master/specifications/transaction_commit

- video: https://www.youtube.com/watch?v=iS9voO5CGBg&ab_channel=TLA%2BVideoCourse

- https://lamport.azurewebsites.net/video/AB2H.tla

## Things I learned
- "throughaly testable psuedo code", "state machineで記述することで全状態を網羅可能にするテスト"
- dealing with concurrent systems が本領っぽい (other methods can deal with non concurrent, 当然 tla+ can deal with non concurrent too.)

## Things I got stuck
- Make a new spec for every file (that can depend on other modules)
- When importing from other modules, use <other_module>!<import_name>, e.g., TC!TCConstant
- Tex に慣れてないと \? 的な記法がきついかもしれない

## AWS paper
- Gradual adoption
- Takes ~3 weeks for a new comer
- Used in the stuff we use every day
- Pretty real decision making 経緯
- TLA+ because of it's extendability and bang for the buck

## Github
- Everything is here (not the webpage)
- Needed to salvage some stuff
