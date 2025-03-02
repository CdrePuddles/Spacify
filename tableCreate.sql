CREATE TABLE Universe (
    UniversalName VARCHAR(50),
    Age REAL,
    ExpansionaryRate REAL,
    PRIMARY KEY (UniversalName)
);

CREATE TABLE Galaxy (
    GalacticName VARCHAR(50),
    Constellation VARCHAR(50),
    VariationType VARCHAR(50),
    Radius REAL,
    Universe VARCHAR(50) NOT NULL,
    PRIMARY KEY (GalacticName),
    FOREIGN KEY (Universe) REFERENCES Universe(UniversalName) ON DELETE CASCADE
);

CREATE TABLE PlanetarySystem (
    HostName VARCHAR(50),
    NumberOfStars INT,
    NumberOfPlanets INT,
    Radius REAL,
    Host VARCHAR(50) NOT NULL,
    PRIMARY KEY (HostName),
    FOREIGN KEY (Host) REFERENCES Galaxy(GalacticName) ON DELETE CASCADE
);

CREATE TABLE Quasar (
    QuasarName VARCHAR(50),
    SpectralRedshift REAL,
    DistanceFromEarth REAL,
    Luminosity REAL,
    Universe VARCHAR(50) NOT NULL,
    PRIMARY KEY (QuasarName),
    FOREIGN KEY (Universe) REFERENCES Universe(UniversalName) ON DELETE CASCADE
);

CREATE TABLE CelestialBody (
    CelestialName VARCHAR(50),
    DiscoveryYear INT,
    ObjectType CHAR(1) NOT NULL,
    PRIMARY KEY (CelestialName),
    UNIQUE (CelestialName, ObjectType),
    CHECK (ObjectType IN ('S', 'P')) -- validates object type
);

CREATE TABLE Star (
    SolarName VARCHAR(50),
    SpectralType CHAR(10),
    Radius REAL,
    ElementalComposition VARCHAR(50),
    GalacticHost VARCHAR(50) NOT NULL,
    ObjectType CHAR(1) NOT NULL,
    PRIMARY KEY (SolarName),
    FOREIGN KEY (GalacticHost) REFERENCES PlanetarySystem(HostName) ON DELETE CASCADE,
    FOREIGN KEY (SolarName, ObjectType) REFERENCES CelestialBody(CelestialName, ObjectType) ON DELETE CASCADE,
    CHECK (ObjectType = 'S')
);

CREATE TABLE Exoplanet (
    PlanetaryName VARCHAR(50),
    Radius REAL,
    DurationOfDay REAL,
    OrbitalPeriod REAL,
    PlanetaryType VARCHAR(50),
    GravityStrength VARCHAR(50),
    Biosphere INT,
    SolarHost VARCHAR(50) NOT NULL,
    ObjectType CHAR(1) NOT NULL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (SolarHost) REFERENCES Star(SolarName) ON DELETE CASCADE,
    FOREIGN KEY (PlanetaryName, ObjectType) REFERENCES CelestialBody(CelestialName, ObjectType) ON DELETE CASCADE,
    CHECK (ObjectType = 'P')
);

/*
CREATE TABLE Orbits_Star (
    PlanetaryName VARCHAR(50),
    SolName VARCHAR(50),
    OrbitalPeriod REAL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE,
    FOREIGN KEY (SolName) REFERENCES Star(SolarName) ON DELETE CASCADE
);*/

CREATE TABLE Moon (
    LunarName VARCHAR(50),
    Radius REAL,
    TidalLock INT,
    CoreComposition VARCHAR(50),
    OrbitalPeriod REAL,
    DiscoveryYear INT,
    Host VARCHAR(50) NOT NULL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (Host) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE
);

/*
CREATE TABLE Orbits_Planet (
    LunarName VARCHAR(50),
    Planet VARCHAR(50) NOT NULL,
    OrbitalPeriod REAL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (LunarName) REFERENCES Moon(LunarName) ON DELETE CASCADE,
    FOREIGN KEY (Planet) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE
);
*/

CREATE TABLE Biome (
    BiomeType VARCHAR(50),
    AverageTemperature REAL,
    EcologicalComposition VARCHAR(50),
    PRIMARY KEY (BiomeType)
);

CREATE TABLE Ecosystem (
    Planet VARCHAR(50),
    Biome VARCHAR(50),
    --Phylum VARCHAR(50) NOT NULL,
    PRIMARY KEY (Planet, Biome),
    FOREIGN KEY (Planet) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE,
    FOREIGN KEY (Biome) REFERENCES Biome(BiomeType) ON DELETE CASCADE
    --FOREIGN KEY (Phylum) REFERENCES Kingdom(Phylum)
);

CREATE TABLE Kingdom (
    Phylum VARCHAR(50),
    ColloquialGenus VARCHAR(50),
    TrophicLevel VARCHAR(50),
    --Planet VARCHAR(50) NOT NULL,
    --Biome VARCHAR(50) NOT NULL,
    PRIMARY KEY (Phylum)
    --FOREIGN KEY (Planet, Biome) REFERENCES Ecosystem(PlanetaryName, BiomeType) ON DELETE CASCADE,
    --UNIQUE (Phylum, Planet, BiomeType)
);

CREATE TABLE Has_Kingdom(
    Phylum VARCHAR(50),
    Planet VARCHAR(50),
    Biome VARCHAR(50),
    Alleles INT,
    PRIMARY KEY (Phylum, Planet, Biome),
    FOREIGN KEY (Phylum) REFERENCES Kingdom(Phylum) ON DELETE CASCADE,
    FOREIGN KEY (Planet, Biome) REFERENCES Ecosystem(Planet, Biome) ON DELETE CASCADE
    --UNIQUE (Phylum, Planet, Biome)
);


/*
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
*/