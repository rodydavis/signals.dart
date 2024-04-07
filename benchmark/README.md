# Signals Benchmark

## Results
Date: 2024-04-07T22:40:05.756143

| name                                    | total runs | average run | runs/second | units/second | time per unit | total time | units |
|-----------------------------------------|------------|-------------|-------------|--------------|---------------|------------|-------|
| signals: signal => 0 subscribers        | 12393      | 161 μs      | 6211.18     | 62111801.24  | 0.0161 μs     | 2.0001  s  | 10000 |
| signals: signal => 1 subscribers        | 3990       | 501 μs      | 1996.01     | 19960079.84  | 0.0501 μs     | 2.0000  s  | 10000 |
| signals: signal => 10 subscribers       | 547        | 3.6580 ms   | 273.37      | 2733734.28   | 0.3658 μs     | 2.0011  s  | 10000 |
| signals: signal => 100 subscribers      | 48         | 41.976 ms   | 23.82       | 238231.37    | 4.1976 μs     | 2.0149  s  | 10000 |
| solidart: signal => 0 subscribers       | 2403       | 832 μs      | 1201.92     | 12019230.77  | 0.0832 μs     | 2.0005  s  | 10000 |
| solidart: signal => 1 subscribers       | 369        | 5.4290 ms   | 184.20      | 1841959.85   | 0.5429 μs     | 2.0035  s  | 10000 |
| solidart: signal => 10 subscribers      | 34         | 59.453 ms   | 16.82       | 168200.09    | 5.9453 μs     | 2.0214  s  | 10000 |
| solidart: signal => 100 subscribers     | 4          | 590.43 ms   | 1.69        | 16936.87     | 59.043 μs     | 2.3617  s  | 10000 |
| state_beacon: signal => 0 subscribers   | 14001      | 142 μs      | 7042.25     | 70422535.21  | 0.0142 μs     | 2.0000  s  | 10000 |
| state_beacon: signal => 1 subscribers   | 6319       | 316 μs      | 3164.56     | 31645569.62  | 0.0316 μs     | 2.0004  s  | 10000 |
| state_beacon: signal => 10 subscribers  | 642        | 3.1160 ms   | 320.92      | 3209242.62   | 0.3116 μs     | 2.0007  s  | 10000 |
| state_beacon: signal => 100 subscribers | 94         | 21.426 ms   | 46.67       | 466722.67    | 2.1426 μs     | 2.0141  s  | 10000 |
