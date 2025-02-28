CREATE TABLE Universe (
    UniversalName CHAR(30),
    Age REAL,
    ExpansionaryRate REAL,
    PRIMARY KEY (UniversalName)
)

CREATE TABLE Galaxy (
    GalacticName CHAR(30),
    Constellation CHAR(30),
    SpectralType CHAR(20),
    Radius REAL,
    PRIMARY KEY (GalacticName)
)

CREATE TABLE PlanetarySystem (
    HostName CHAR(30),
    NumberOfStars INT,
    NumberOfPlanets INT,
    Radius REAL,
    Host CHAR (30) NOT NULL,
    PRIMARY KEY (HostName),
    FOREIGN KEY (Host) REFERENCES Galaxy
)

CREATE TABLE Quasar (
    QuasarName CHAR(30),
    SpectralRedshift REAL,
    DistanceFromEarth REAL,
    Luminosity REAL,
    PRIMARY KEY (QuasarName)
)

CREATE TABLE Star (
    SolarName CHAR(30),
    SpectralType CHAR(8),
    Radius REAL,
    ElementalComposition CHAR(30),
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (SolarName),
    FOREIGN KEY (Host) REFERENCES PlanetarySystem
)

CREATE TABLE Exoplanet (
    PlanetaryName CHAR(30),
    Radius REAL,
    DurationOfDay REAL,
    PlanetaryType CHAR(30),
    Biosphere INT,
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (Host) REFERENCES Star
)

CREATE TABLE Orbits_Star (
    PlanetaryName CHAR(30),
    SolName CHAR(30),
    OrbitalPeriod REAL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet,
    FOREIGN KEY (SolName) REFERENES Star
)

CREATE TABLE Moon (
    LunarName CHAR(30),
    Radius REAL,
    TidalLock INT,
    CoreComposition CHAR(30),
    DiscoveryYear INT,
    Host CHAR(30) NOT NULL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (Host) REFERENCES Exoplanet
)

CREATE TABLE Orbits_Planet (
    LunarName CHAR(30),
    PlanetaryName CHAR(30) NOT NULL,
    OrbitalPeriod REAL,
    PRIMARY KEY (LunarName),
    FOREIGN KEY (LunarName) REFERENCES Moon,
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet
)

CREATE TABLE Biome (
    BiomeType CHAR(30),
    AverageTemperature REAL,
    EcologicalComposition CHAR(20),
    PRIMARY KEY (BiomeType)
)

CREATE TABLE Ecosystem (
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    Phylum CHAR(30),
    PRIMARY KEY (PlanetaryName, BiomeType),
    FOREIGN KEY (PlanetaryName) REFERENCES Exoplanet,
    FOREIGN KEY (BiomeType) REFERENCES Biome
    FOREIGN KEY (Phylum) REFERENCES Kingdom
)

CREATE TABLE Kingdom (
    Phylum CHAR(30),
    TrophicLevel CHAR(40),
    ColloquialGenus CHAR(50),
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    PRIMARY KEY (Phylum),
    FOREIGN KEY (PlanetaryName, BiomeType) REFERENCES Ecosystem
)

CREATE TABLE Has_Kingdom(
    Phylum CHAR(30),
    PlanetaryName CHAR(30),
    BiomeType CHAR(30),
    PRIMARY KEY (Phylum, PlanetaryName, BiomeType),
    FOREIGN KEY (Phylum) REFERENCES Kingdom,
    FOREIGN KEY (PlanetaryName, BiomeType) REFERENCES Ecosystem,
    UNIQUE (Phylum, PlanetaryName, BiomeType)
)