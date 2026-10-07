# \# PL/SQL GOTO Statements and Functions - Individual Assignment III

# 

# \*\*Name:\*\* Ishimwe Ntwari Dylan

# \*\*Student ID:\*\* 29764

# \*\*Course:\*\* Database development with PL/SQL

# \*\*Lecturer:\*\* Eric Maniraguha

# 

# \## Project: Employee \& Payroll Management System

# 

# A small Oracle database with `departments` and `employees` tables.

# All tasks use this same database.

# 

# \## Environment

# \- Oracle Database 21c Enterprise Edition (Windows)

# \- Pluggable database: DY\_PDB\_29764

# \- Tool: SQL\*Plus

# \- Version control: Git and GitHub

# 

# \## How to run

# 1\. Connect to the PDB as `User-Name`.

# 2\. Run `00\_setup/create\_tables.sql` first.

# 3\. Run the other scripts in the order below.

# 

# \## Repository structure

# 

# | Folder | Task | Description |

# |---|---|---|

# | 00\_setup | Setup | Tables and sample data |

# | 01\_goto | A1 | Number classifier using GOTO |

# | 01\_goto | A2 | Salary review using GOTO in a loop |

# | 01\_goto | A3 | Illegal GOTO (jump into an IF) and its fix |

# | 01\_goto | A4 | Salary review rewritten without GOTO |

# | 02\_functions | B1 | `fn\_annual\_salary` (monthly salary x 12) |

# | 02\_functions | B2 | `fn\_years\_of\_service` (full years since hire) |

# | 02\_functions | B3 | `fn\_calculate\_tax` (progressive tax bands) |

# | 02\_functions | B4 | `fn\_dept\_name` (department name or 'Unassigned') |

# | 02\_functions | C1 | `fn\_validate\_payroll` (user-defined exceptions) |

# | 03\_tests | B5 | Functions used inside SELECT, WHERE, ORDER BY |

# | 03\_tests | Tests | `test\_functions.sql`, `test\_validate\_payroll.sql` |

# | screenshots | Evidence | Output of every task |

# | docs | C2 | `REFLECTION.md` |

# 

# \## Assumptions

# \- `salary` is a monthly salary.

# \- Tax bands: 0% up to 60,000; 20% from 60,001 to 100,000; 30% above 100,000.

# 

# \## Screenshots

# All screenshots are in the `screenshots/` folder, named after the task (for example `A1\_negative.png`, `B3\_calculate\_tax.png`). Functions

