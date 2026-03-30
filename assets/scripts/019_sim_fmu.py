"""
Simulating our FMU with FMPy
=============================
Article 019 of the "Learn Modelica & FMI" newsletter.

This script demonstrates how to use FMPy to:
  1. Inspect an FMU (model info, variables, parameters)
  2. Simulate the FMU with default parameters
  3. Plot results with matplotlib
  4. Compare simulations with different parameters using Plotly
  5. Change parameter values (spring stiffness study)

The FMU was exported from the SuspendedMass Modelica model
developed in articles 017 and 018.

Author: Clément Coïc
Date:   2026-02-11
License: CC BY-NC 4.0

Requirements:
    uv add fmpy matplotlib plotly kaleido

Usage:
    python 019_sim_fmu.py
"""

from pathlib import Path

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Path to the FMU file (relative to this script's location)
FMU_PATH = str(Path(__file__).parent.parent / "models" / "019_SuspendedMass.fmu")


# ---------------------------------------------------------------------------
# 1. Inspect the FMU
# ---------------------------------------------------------------------------
# The dump() function prints model info, variables, and default experiment
# settings — the same information you'd see in the FMPy GUI.

from fmpy import dump

print("=" * 60)
print("FMU Information")
print("=" * 60)
dump(FMU_PATH)


# ---------------------------------------------------------------------------
# 2. Simulate with default parameters
# ---------------------------------------------------------------------------
# simulate_fmu() returns a NumPy structured array where each column is a
# variable (time, position x, speed v, ...) and each row is a time step.

from fmpy import simulate_fmu

result = simulate_fmu(FMU_PATH, stop_time=4)

print("\nColumn names:", result.dtype.names)
print("Number of time steps:", result.shape)


# ---------------------------------------------------------------------------
# 3. Plot with matplotlib
# ---------------------------------------------------------------------------
# A simple plot of the mass position over time, showing the damped
# oscillation converging to the steady-state equilibrium.

import matplotlib.pyplot as plt

plt.figure(figsize=(10, 5))
plt.plot(result['time'], result['x'], label='Position x')
plt.xlabel('Time [s]')
plt.ylabel('Position [m]')
plt.title('Suspended Mass - Damped Oscillation')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()


# ---------------------------------------------------------------------------
# 4. Compare two simulations with Plotly
# ---------------------------------------------------------------------------
# We run two simulations: one with the default spring stiffness (k=1000 N/m)
# and one with a stiffer spring (k=5000 N/m). The comparison shows how the
# stiffer spring leads to faster oscillation and a steady-state position
# closer to the spring rest length.

import plotly.graph_objects as go

# Default spring stiffness (k=1000)
# (result already computed above)

# Stiffer spring (k=5000)
result_stiff = simulate_fmu(
    FMU_PATH,
    stop_time=4,
    start_values={'k': 5000}
)

fig = go.Figure()
fig.add_trace(go.Scatter(
    x=result['time'],
    y=result['x'],
    mode='lines',
    name='k = 1000 N/m (default)'
))
fig.add_trace(go.Scatter(
    x=result_stiff['time'],
    y=result_stiff['x'],
    mode='lines',
    name='k = 5000 N/m (stiffer)'
))
fig.update_layout(
    title='Suspended Mass - Effect of Spring Stiffness',
    xaxis_title='Time [s]',
    yaxis_title='Position [m]',
    template='plotly_white'
)
fig.show()


# ---------------------------------------------------------------------------
# 5. Print comparison summary
# ---------------------------------------------------------------------------

print("\n" + "=" * 60)
print("Parameter Study Summary")
print("=" * 60)
print(f"  Default (k=1000): final position = {result['x'][-1]:.4f} m")
print(f"  Stiffer (k=5000): final position = {result_stiff['x'][-1]:.4f} m")
