# Electric Kettle Tilt Mechanism Analysis

A MATLAB engineering analysis comparing the modeled handling forces and wrist moments of a traditional electric kettle with a redesigned kettle supported by a tilt mechanism.

## Project overview

The script estimates the torque needed to hold the redesigned kettle at pouring angles from 0° to 45° in 5° increments. It compares the resulting handle force against a traditional lifting-force estimate and plots the handle force and torque across the angle range.

## Methods

- Static torque balance using a simplified center-of-mass offset.
- Handle-force calculation from torque and handle distance.
- Wrist-moment comparison using assumed moment arms.
- Preallocated arrays, a loop over tilt angles, formatted console output, and MATLAB plots.

The simplified model uses:

```text
Traditional grip force = 1.2 × total mass × g
Tilt torque = total mass × g × horizontal COM offset × cos(tilt angle)
Handle force = tilt torque / handle distance
```

## Run the project

1. Download this folder or clone the repository.
2. Open `Reveseengmatlab.m` in MATLAB.
3. Run the script, or navigate to this folder in MATLAB and enter:

```matlab
run('Reveseengmatlab.m')
```

The script prints the comparisons in the Command Window and opens a figure containing force and torque plots. It requires no input data files or additional MATLAB toolboxes. Use a MATLAB release that supports `yline` (R2018b or later).

## Results from the supplied parameters

| Quantity | Modeled value |
| --- | ---: |
| Total kettle and water mass | 2.00 kg |
| Traditional grip force estimate | 23.54 N |
| Maximum redesigned handle force | 6.54 N |
| Handle force reduction | 72.2% |
| Traditional wrist moment | 5.89 N·m |
| Redesigned wrist moment | 0.65 N·m |
| Wrist moment reduction | 88.9% |

These values are calculated from the script's equations and default parameters; they are not experimental measurements. The script was not executed in MATLAB as part of this upload.

## Assumptions and limitations

The model assumes a fixed total mass, a 0.05 m horizontal center-of-mass offset, a 0.15 m handle distance, and quasi-static motion. It does not model changing water distribution, friction, acceleration, structural stresses, or human-subject performance. Some geometric parameters defined in the script are not used in the torque equation.

The script's 10 N threshold is an assumed comparison benchmark. Its printed safety and accessibility statements do not establish clinical safety or compliance with accessibility standards. The results illustrate the simplified model and require further validation before making such claims.

## Files

- [Reveseengmatlab.m](Reveseengmatlab.m): original uploaded MATLAB script.
