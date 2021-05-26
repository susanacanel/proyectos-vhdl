from pathlib import Path
from vunit import VUnit

VU = VUnit.from_argv()

ROOT = Path(__file__).parent

VU.add_library("lib").add_source_files([
    #ROOT / "combinacionales" / "*.vhdl",
    #ROOT / "secuenciales" / "*.vhdl",
    ROOT / "manejo_de_archivos" / "*.vhdl",
])

VU.main()
