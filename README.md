# godot-proto-assets

=================

A small collection of modular, drop-in Godot 4.4.1 assets and utility scenes for fast prototyping. Each module is self-contained (scene + script + minimal assets) so you can copy a folder into any project and get started quickly.

Highlights
- Modular, drop-in design (copy folder into project)
- Prototype-ready examples (FPS controller, interactables, small UI)
- Small and configurable via exported variables in the Inspector
- Intended for Godot 4.4.X

Quick install
- Copy: copy the desired module folder from this repo into your project's folder (e.g. res://fps_controller).
- Check: input mapping. Add from project settings

What’s included
- fps_controller — simple FPS controller:
  - Movement (walk/sprint)
  - Jump
  - Mouse look (head yaw + camera pitch)
  - RayCast3D-based interaction
  - Exported variables for quick tuning
