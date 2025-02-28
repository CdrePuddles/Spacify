CREATE TABLE Universe (
    UniversalName CHAR(30),
    Age REAL,
    ExpansionaryRate REAL,
    PRIMARY KEY (UniversalName)
);

CREATE TABLE Galaxy (
    GalacticName CHAR(30),
    Constellation CHAR(30),
    SpectralType CHAR(20),
    Radius REAL,
    PRIMARY KEY (GalacticName)
);

CREATE TABLE PlanetarySystem (
    HostName CHAR(30),
    NumberOfStars INT,
    NumberOfPlanets INT,
    Radius REAL,
    Host CHAR (30) NOT NULL,
    PRIMARY KEY (HostName),
    FOREIGN KEY (Host) REFERENCES Galaxy(GalacticName)
);

CREATE TABLE Quasar (
    QuasarName CHAR(30),
    SpectralRedshift REAL,
    DistanceFromEarth REAL,
    Luminosity REAL,
    PRIMARY KEY (QuasarName)
);

CREATE TABLE Star (
    SolarName CHAR(30),
    SpectralType CHAR(8),
    Radius REAL,
    ElementalComposition CHAR(30),
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (SolarName),
    FOREIGN KEY (Host) REFERENCES PlanetarySystem(Host)
);

CREATE TABLE Exoplanet (
    PlanetaryName CHAR(30),
    Radius REAL,
    DurationOfDay REAL,
    PlanetaryType CHAR(30),
    Biosphere INT,
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (Host) REFERENCES Star(SolarName)
);

CREATE TABLE Orbits_Star (
    PlanetaryName CHAR(30),
    SolName CHAR(30),
    OrbitalPeriod REAL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet(PlanetaryName),
    FOREIGN KEY (SolName) REFERENCES Star(SolarName)
);

CREATE TABLE Moon (
    LunarName CHAR(30),
    Radius REAL,
    TidalLock INT,
    CoreComposition CHAR(30),
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (Host) REFERENCES Exoplanet(PlanetaryName)
);

CREATE TABLE Orbits_Planet (
    LunarName CHAR(30),
    PlanetaryName CHAR(30) NOT NULL,
    OrbitalPeriod REAL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (LunarName) REFERENCES Moon(LunarName),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet(PlanetaryName)
);

CREATE TABLE Biome (
    BiomeType CHAR(30),
    AverageTemperature REAL,
    EcologicalComposition CHAR(20),
    PRIMARY KEY (BiomeType)
);

CREATE TABLE Ecosystem (
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    Phylum CHAR(30),
    PRIMARY KEY (PlanetaryName, BiomeType),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet(PlanetaryName),
    FOREIGN KEY (BiomeType) REFERENCES Biome(BiomeType)
    FOREIGN KEY (Phylum) REFERENCES Kingdom(Phylum)
);

CREATE TABLE Kingdom (
    Phylum CHAR(30),
    TrophicLevel CHAR(40),
    ColloquialGenus CHAR(50),
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    PRIMARY KEY (Phylum),
    FOREIGN KEY (PlanetaryName, BiomeType) REFERENCES Ecosystem(PlanetaryName, BiomeType)
);

CREATE TABLE Has_Kingdom(
    Phylum CHAR(30),
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    PRIMARY KEY (Phylum, PlanetaryName, BiomeType),
    FOREIGN KEY (Phylum) REFERENCES Kingdom(Phylum),
    FOREIGN KEY (PlanetaryName, BiomeType) REFERENCES Ecosystem(PlanetaryName, BiomeType),
    UNIQUE (Phylum, PlanetaryName, BiomeType)
);

LOAD DATA INFILE 'Data/Universe.csv'
INTO TABLE Galaxy
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UniversalName, Age, ExpansionaryRate);

LOAD DATA INFILE 'Data/Galaxy.csv'
INTO TABLE Galaxy
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(GalacticName, Constellation, SpectralType, Radius);

LOAD DATA INFILE 'Data/PlanetarySystem.csv'
INTO TABLE PlanetarySystem
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(HostName, NumberOfStars, NumberOfPlanets, Radius, Host);

LOAD DATA INFILE 'Data/Quasar.csv'
INTO TABLE Quasar
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(QuasarName, SpectralRedshift, DistanceFromEarth, Luminosity);

LOAD DATA INFILE 'Data/Star.csv'
INTO TABLE Star
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SolarName, SpectralType, Radius, ElementalComposition, DiscoveryYear, Host);

LOAD DATA INFILE 'Data/Planet.csv'
INTO TABLE Exoplanet
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PlanetaryName, Radius, DurationOfDay, PlanetaryType, Biosphere, DiscoveryYear, Host);

LOAD DATA INFILE 'Data/Orbits_Star.csv'
INTO TABLE Orbits_Star
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PlanetaryName, SolName, OrbitalPeriod);

LOAD DATA INFILE 'Data/Moon.csv'
INTO TABLE Moon
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(LunarName, Radius, TidalLock, CoreComposition, DiscoveryYear, Host);

LOAD DATA INFILE 'Data/Orbits_Planet.csv'
INTO TABLE Orbits_Planet
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(LunarName, PlanetaryName, OrbitalPeriod);

LOAD DATA INFILE 'Data/Biome.csv'
INTO TABLE Biome
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BiomeType, AverageTemperature, EcologicalComposition);

LOAD DATA INFILE 'Data/Ecosystem.csv'
INTO TABLE Ecosystem
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PlanetaryName, BiomeType, Phylum);

LOAD DATA INFILE 'Data/Kingdom.csv'
INTO TABLE Kingdom
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Phylum, TrophicLevel, ColloquialGenus, PlanetaryName, BiomeType);

LOAD DATA INFILE 'Data/Has_Kingdom.csv'
INTO TABLE Has_Kingdom
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Phylum, PlanetaryName, BiomeType);
