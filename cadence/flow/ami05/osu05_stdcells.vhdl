LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
LIBRARY IEEE;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;

package prim is

CONSTANT DefCombSpikeMsgOn : BOOLEAN := true;
CONSTANT DefCombSpikeXOn   : BOOLEAN := true;
CONSTANT DefSeqMsgOn       : BOOLEAN := true;
CONSTANT DefSeqXOn         : BOOLEAN := true;

CONSTANT DefDummyDelay    : VitalDelayType := 1.00 ns;
CONSTANT DefDummySetup    : VitalDelayType := 1.00 ns;
CONSTANT DefDummyHold     : VitalDelayType := 1.00 ns;
CONSTANT DefDummyWidth    : VitalDelayType := 1.00 ns;
CONSTANT DefDummyRecovery : VitalDelayType := 1.00 ns;
CONSTANT DefDummyRemoval  : VitalDelayType := 1.00 ns;
CONSTANT DefDummyIpd      : VitalDelayType := 0.00 ns;
CONSTANT DefDummyIsd      : VitalDelayType := 0.00 ns;
CONSTANT DefDummyIcd      : VitalDelayType := 0.00 ns;

CONSTANT udp_dff : VitalStateTableType (1 TO 21, 1 TO 7) := (
--    NOTIFIER   D      CLK     RN       S      Q(t)   Q(t+1)
     (  'X',    '-',    '-',    '-',    '-',    '-',    'X'  ),
     (  '-',    '-',    '-',    '-',    '1',    '-',    '1'  ),
     (  '-',    '-',    '-',    '1',    '0',    '-',    '0'  ),
     (  '-',    '0',    '/',    '-',    '0',    '-',    '0'  ),
     (  '-',    '1',    '/',    '0',    '-',    '-',    '1'  ),
     (  '-',    '1',    '*',    '0',    '-',    '1',    '1'  ),
     (  '-',    '0',    '*',    '-',    '0',    '0',    '0'  ),
     (  '-',    '-',    '\',   '-',    '-',    '-',    'S'  ),
     (  '-',    '*',    'B',    '-',    '-',    '-',    'S'  ),
     (  '-',    '-',    'B',    '0',    '*',    '1',    '1'  ),
     (  '-',    '1',    'X',    '0',    '*',    '1',    '1'  ),
     (  '-',    '-',    'B',    '*',    '0',    '0',    '0'  ),
     (  '-',    '0',    'X',    '*',    '0',    '0',    '0'  ),
     (  '-',    'B',    'r',    '-',    '-',    '-',    'X'  ),
     (  '-',    '/',    'X',    '-',    '-',    '-',    'X'  ),
     (  '-',    '-',    '-',    '-',    '*',    '-',    'X'  ),
     (  '-',    '-',    '-',    '*',    '-',    '-',    'X'  ),
     (  '-',    '-',    'f',    '-',    '-',    '-',    'X'  ),
     (  '-',    '\',   'X',    '0',    '-',    '-',    'X'  ),
     (  '-',    'B',    'X',    '-',    '-',    '-',    'S'  ),
     (  '-',    '-',    'S',    '-',    '-',    '-',    'S'  ));

CONSTANT udp_tlat : VitalStateTableType (1 TO 20, 1 TO 7) := (
--      NOT      D       G       R       S      Q(t)  Q(t+1)
     (  'X',    '-',    '-',    '-',    '-',    '-',    'X'  ),
     (  '-',    '-',    '-',    '-',    '1',    '-',    '1'  ),
     (  '-',    '-',    '-',    '1',    '0',    '-',    '0'  ),
     (  '-',    '1',    '1',    '0',    '-',    '-',    '1'  ),
     (  '-',    '0',    '1',    '-',    '0',    '-',    '0'  ),
     (  '-',    '1',    '*',    '0',    '-',    '1',    '1'  ),
     (  '-',    '0',    '*',    '-',    '0',    '0',    '0'  ),
     (  '-',    '*',    '0',    '-',    '-',    '-',    'S'  ),
     (  '-',    '-',    '0',    '0',    '*',    '1',    '1'  ),
     (  '-',    '1',    '-',    '0',    '*',    '1',    '1'  ),
     (  '-',    '-',    '0',    '*',    '0',    '0',    '0'  ),
     (  '-',    '0',    '-',    '*',    '0',    '0',    '0'  ),
     (  '-',    '0',    '-',    '-',    '0',    '0',    '0'  ),
     (  '-',    '1',    '-',    '0',    '-',    '1',    '1'  ),
     (  '-',    '*',    '-',    '-',    '-',    '-',    'X'  ),
     (  '-',    '-',    '-',    '*',    '-',    '-',    'X'  ),
     (  '-',    '-',    '-',    '-',    '*',    '-',    'X'  ),
     (  '-',    'B',    'r',    '0',    '0',    '-',    'X'  ),
     (  '-',    'B',    'X',    '0',    '0',    '-',    'S'  ),
     (  '-',    '-',    'S',    '-',    '-',    '-',    'S'  ) );

CONSTANT udp_rslat : VitalStateTableType (1 TO 12, 1 TO 5) := (
--      NOT      R       S      Q(t)  Q(t+1)
     (  'X',    '-',    '-',    '-',    'X'  ),
     (  '-',    '-',    '1',    '-',    '1'  ),
     (  '-',    '1',    '0',    '-',    '0'  ),
     (  '-',    '0',    '-',    '1',    '1'  ),
     (  '-',    '-',    '0',    '0',    '0'  ),
     (  '-',    '-',    '-',    '-',    'S'  ),
     (  '-',    '0',    '*',    '1',    '1'  ),
     (  '-',    '*',    '0',    '0',    '0'  ),
     (  '-',    '-',    '0',    '0',    '0'  ),
     (  '-',    '0',    '-',    '1',    '1'  ),
     (  '-',    '*',    '-',    '-',    'X'  ),
     (  '-',    '-',    '*',    '-',    'X'  ) );


end prim;

package body prim is

end prim;
LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity AND2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.135468 ns, 0.167177 ns);
             tpd_B_Y : VitalDelayType01 := (0.136152 ns, 0.184677 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of AND2X1 : entity is TRUE;
end AND2X1;

architecture behavioral of AND2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalAND2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity AND2X2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.16526 ns, 0.197548 ns);
             tpd_B_Y : VitalDelayType01 := (0.165586 ns, 0.21246 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of AND2X2 : entity is TRUE;
end AND2X2;

architecture behavioral of AND2X2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalAND2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity AOI21X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.119567 ns, 0.110736 ns);
             tpd_B_Y : VitalDelayType01 := (0.105819 ns, 0.110229 ns);
             tpd_C_Y : VitalDelayType01 := (0.0852486 ns, 0.120576 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of AOI21X1 : entity is TRUE;
end AOI21X1;

architecture behavioral of AOI21X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalAND2(A_ipd, B_ipd);
          n1_var := VitalOR2(n0_var, C_ipd);
          Y_zd := VitalINV(n1_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity AOI22X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.131377 ns, 0.133942 ns);
             tpd_B_Y : VitalDelayType01 := (0.120762 ns, 0.133469 ns);
             tpd_C_Y : VitalDelayType01 := (0.107957 ns, 0.094805 ns);
             tpd_D_Y : VitalDelayType01 := (0.0979614 ns, 0.0937163 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of AOI22X1 : entity is TRUE;
end AOI22X1;

architecture behavioral of AOI22X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
   VitalWireDelay( D_ipd, D, tipd_D );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd, D_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE n2_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalAND2(A_ipd, B_ipd);
          n1_var := VitalAND2(C_ipd, D_ipd);
          n2_var := VitalOR2(n0_var, n1_var);
          Y_zd := VitalINV(n2_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE),
                      3 => ( D_ipd'LAST_EVENT,
                             tpd_D_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity BUFX2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.190325 ns, 0.184353 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of BUFX2 : entity is TRUE;
end BUFX2;

architecture behavioral of BUFX2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalBUF(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity BUFX4 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.206474 ns, 0.204188 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of BUFX4 : entity is TRUE;
end BUFX4;

architecture behavioral of BUFX4 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalBUF(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity CLKBUF1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.254868 ns, 0.262935 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of CLKBUF1 : entity is TRUE;
end CLKBUF1;

architecture behavioral of CLKBUF1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalBUF(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity CLKBUF2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.372019 ns, 0.381695 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of CLKBUF2 : entity is TRUE;
end CLKBUF2;

architecture behavioral of CLKBUF2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalBUF(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity CLKBUF3 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.490149 ns, 0.499249 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of CLKBUF3 : entity is TRUE;
end CLKBUF3;

architecture behavioral of CLKBUF3 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalBUF(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity DFFNEGX1 is
   generic (
             tipd_CLK : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             ticd_CLK : VitalDelayType := DefDummyIcd;
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_D_CLK : VitalDelayType := DefDummyIsd;
             tsetup_D_CLK_posedge_negedge : VitalDelayType := 0.28125 ns;
             tsetup_D_CLK_negedge_negedge : VitalDelayType := 0.375 ns;
             thold_D_CLK_posedge_negedge : VitalDelayType := -0.0937499 ns;
             thold_D_CLK_negedge_negedge : VitalDelayType := -0.0937499 ns;
             tpw_CLK_posedge : VitalDelayType := 0.175165 ns;
             tpw_CLK_negedge : VitalDelayType := 0.20336 ns;
             tpd_CLK_Q : VitalDelayType01 := (0.265606 ns, 0.235277 ns);

             TimingChecksOn : BOOLEAN := false;
             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         CLK : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         Q : out std_ulogic);

   attribute VITAL_LEVEL0 of DFFNEGX1 : entity is TRUE;
end DFFNEGX1;

architecture behavioral of DFFNEGX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL CLK_dly : std_ulogic := 'X';
   SIGNAL CLK_ipd : std_ulogic := 'X';
   SIGNAL D_dly : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( CLK_ipd, CLK, tipd_CLK );
   VitalWireDelay( D_ipd, D, tipd_D );
END BLOCK;

SIGNALDELAY : BLOCK
BEGIN
   VitalSignalDelay( CLK_dly, CLK_ipd, ticd_CLK );
   VitalSignalDelay( D_dly, D_ipd, tisd_D_CLK );
END BLOCK;

VITALBehavior : PROCESS (CLK_dly, D_dly)

      --timing checks section variables
      VARIABLE Tviol_D_CLK : std_ulogic := '0';
      VARIABLE TimeMarker_D_CLK : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE PWviol_CLK : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_CLK : VitalPeriodDataType;

      -- functionality section variables
      VARIABLE intclk : std_ulogic;
      VARIABLE n0_RN_dly : std_ulogic := '0';
      VARIABLE n0_SN_dly : std_ulogic := '0';
      VARIABLE DS0000 : std_ulogic;
      VARIABLE P0002 : std_ulogic;
      VARIABLE n0_vec : std_logic_vector( 1 TO 1 );
      VARIABLE PrevData_udp_dff_n0 : std_logic_vector( 0 TO 4 );
      VARIABLE Q_zd : std_ulogic;
      VARIABLE NOTIFIER : std_ulogic := '0';

      -- path delay section variables
      VARIABLE Q_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Timing checks section
          IF (TimingChecksOn) THEN

                VitalSetupHoldCheck (
                    TestSignal     => D_dly,
                    TestSignalName => "D",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    SetupHigh      => tsetup_D_CLK_posedge_negedge,
                    SetupLow       => tsetup_D_CLK_negedge_negedge,
                    HoldHigh       => thold_D_CLK_negedge_negedge,
                    HoldLow        => thold_D_CLK_posedge_negedge,
                    CheckEnabled   => TRUE,
                    RefTransition  => 'F',
                    HeaderMsg      => InstancePath & "/DFFNEGX1",
                    TimingData     => TimeMarker_D_CLK,
                    Violation      => Tviol_D_CLK,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => CLK_dly,
                    TestSignalName => "CLK",
                    Period         => 0 ps,
                    PulseWidthHigh => tpw_CLK_posedge,
                    PulseWidthLow  => tpw_CLK_negedge,
                    PeriodData     => PeriodCheckInfo_CLK,
                    Violation      => PWviol_CLK,
                    HeaderMsg      => InstancePath & "/DFFNEGX1",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

          END IF;


          -- Functionality section
          NOTIFIER := (
                        Tviol_D_CLK OR
                        PWviol_CLK );

          intclk := VitalINV(CLK_dly);

          n0_RN_dly := '0';

          n0_SN_dly := '0';

          VitalStateTable ( StateTable => udp_dff,
                                DataIn => (NOTIFIER, D_dly, intclk, n0_RN_dly, n0_SN_dly),
                             NumStates => 1,
                                Result => n0_vec,
                        PreviousDataIn => PrevData_udp_dff_n0 );

          DS0000 := n0_vec(1);

          P0002 := VitalINV(DS0000);

          Q_zd := VitalBUF(DS0000);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Q,
               OutSignalName => "Q",
               OutTemp => Q_zd,
               Paths => (
                      0 => ( CLK_dly'LAST_EVENT,
                             tpd_CLK_Q,
                             TRUE)),
               GlitchData => Q_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity DFFPOSX1 is
   generic (
             tipd_CLK : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             ticd_CLK : VitalDelayType := DefDummyIcd;
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_D_CLK : VitalDelayType := DefDummyIsd;
             tsetup_D_CLK_posedge_posedge : VitalDelayType := 0.28125 ns;
             tsetup_D_CLK_negedge_posedge : VitalDelayType := 0.28125 ns;
             thold_D_CLK_posedge_posedge : VitalDelayType := -0.0937499 ns;
             thold_D_CLK_negedge_posedge : VitalDelayType := -0.0937499 ns;
             tpw_CLK_posedge : VitalDelayType := 0.203847 ns;
             tpw_CLK_negedge : VitalDelayType := 0.179122 ns;
             tpd_CLK_Q : VitalDelayType01 := (0.210303 ns, 0.303149 ns);

             TimingChecksOn : BOOLEAN := false;
             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         CLK : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         Q : out std_ulogic);

   attribute VITAL_LEVEL0 of DFFPOSX1 : entity is TRUE;
end DFFPOSX1;

architecture behavioral of DFFPOSX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL CLK_dly : std_ulogic := 'X';
   SIGNAL CLK_ipd : std_ulogic := 'X';
   SIGNAL D_dly : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( CLK_ipd, CLK, tipd_CLK );
   VitalWireDelay( D_ipd, D, tipd_D );
END BLOCK;

SIGNALDELAY : BLOCK
BEGIN
   VitalSignalDelay( CLK_dly, CLK_ipd, ticd_CLK );
   VitalSignalDelay( D_dly, D_ipd, tisd_D_CLK );
END BLOCK;

VITALBehavior : PROCESS (CLK_dly, D_dly)

      --timing checks section variables
      VARIABLE Tviol_D_CLK : std_ulogic := '0';
      VARIABLE TimeMarker_D_CLK : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE PWviol_CLK : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_CLK : VitalPeriodDataType;

      -- functionality section variables
      VARIABLE intclk : std_ulogic;
      VARIABLE n0_RN_dly : std_ulogic := '0';
      VARIABLE n0_SN_dly : std_ulogic := '0';
      VARIABLE DS0000 : std_ulogic;
      VARIABLE P0002 : std_ulogic;
      VARIABLE n0_vec : std_logic_vector( 1 TO 1 );
      VARIABLE PrevData_udp_dff_n0 : std_logic_vector( 0 TO 4 );
      VARIABLE Q_zd : std_ulogic;
      VARIABLE NOTIFIER : std_ulogic := '0';

      -- path delay section variables
      VARIABLE Q_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Timing checks section
          IF (TimingChecksOn) THEN

                VitalSetupHoldCheck (
                    TestSignal     => D_dly,
                    TestSignalName => "D",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    SetupHigh      => tsetup_D_CLK_posedge_posedge,
                    SetupLow       => tsetup_D_CLK_negedge_posedge,
                    HoldHigh       => thold_D_CLK_negedge_posedge,
                    HoldLow        => thold_D_CLK_posedge_posedge,
                    CheckEnabled   => TRUE,
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFPOSX1",
                    TimingData     => TimeMarker_D_CLK,
                    Violation      => Tviol_D_CLK,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => CLK_dly,
                    TestSignalName => "CLK",
                    Period         => 0 ps,
                    PulseWidthHigh => tpw_CLK_posedge,
                    PulseWidthLow  => tpw_CLK_negedge,
                    PeriodData     => PeriodCheckInfo_CLK,
                    Violation      => PWviol_CLK,
                    HeaderMsg      => InstancePath & "/DFFPOSX1",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

          END IF;


          -- Functionality section
          NOTIFIER := (
                        Tviol_D_CLK OR
                        PWviol_CLK );

          intclk := VitalBUF(CLK_dly);

          n0_RN_dly := '0';

          n0_SN_dly := '0';

          VitalStateTable ( StateTable => udp_dff,
                                DataIn => (NOTIFIER, D_dly, intclk, n0_RN_dly, n0_SN_dly),
                             NumStates => 1,
                                Result => n0_vec,
                        PreviousDataIn => PrevData_udp_dff_n0 );

          DS0000 := n0_vec(1);

          P0002 := VitalINV(DS0000);

          Q_zd := VitalBUF(DS0000);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Q,
               OutSignalName => "Q",
               OutTemp => Q_zd,
               Paths => (
                      0 => ( CLK_dly'LAST_EVENT,
                             tpd_CLK_Q,
                             TRUE)),
               GlitchData => Q_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity DFFSR is
   generic (
             tipd_CLK : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             ticd_CLK : VitalDelayType := DefDummyIcd;
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_D_CLK : VitalDelayType := DefDummyIsd;
             tipd_R : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_R_CLK : VitalDelayType := DefDummyIsd;
             tipd_S : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_S_CLK : VitalDelayType := DefDummyIsd;
             trecovery_R_CLK_posedge_posedge : VitalDelayType := -0.1875 ns;
             tremoval_R_CLK_posedge_posedge : VitalDelayType := 0.28125 ns;
             trecovery_R_S_posedge_posedge : VitalDelayType := 0.0000000619889 ns;
             trecovery_S_CLK_posedge_posedge : VitalDelayType := 0 ns;
             tremoval_S_CLK_posedge_posedge : VitalDelayType := 0.1875 ns;
             trecovery_S_R_posedge_posedge : VitalDelayType := 0.0937499 ns;
             tsetup_D_CLK_posedge_posedge : VitalDelayType := 0.1875 ns;
             tsetup_D_CLK_negedge_posedge : VitalDelayType := 0.0937499 ns;
             thold_D_CLK_posedge_posedge : VitalDelayType := 0.0000000619889 ns;
             thold_D_CLK_negedge_posedge : VitalDelayType := 0.0937499 ns;
             tpw_S_negedge : VitalDelayType := 0.264082 ns;
             tpw_R_negedge : VitalDelayType := 0.22713 ns;
             tpw_CLK_posedge : VitalDelayType := 0.488409 ns;
             tpw_CLK_negedge : VitalDelayType := 0.332997 ns;
             tremoval_S_R_posedge_posedge : VitalDelayType := VitalZeroDelay;
             tremoval_R_S_posedge_posedge : VitalDelayType := VitalZeroDelay;
             tpd_CLK_Q : VitalDelayType01 := (0.573866 ns, 0.652297 ns);
             tpd_R_Q : VitalDelayType01 := (0.32923 ns, 0.40782 ns);
             tpd_S_Q : VitalDelayType01 := (0.463437 ns, 0 ns);

             TimingChecksOn : BOOLEAN := false;
             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         CLK : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         R : in std_ulogic := 'U' ;
         S : in std_ulogic := 'U' ;
         Q : out std_ulogic);

   attribute VITAL_LEVEL0 of DFFSR : entity is TRUE;
end DFFSR;

architecture behavioral of DFFSR is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL CLK_dly : std_ulogic := 'X';
   SIGNAL CLK_ipd : std_ulogic := 'X';
   SIGNAL D_dly : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';
   SIGNAL R_dly : std_ulogic := 'X';
   SIGNAL R_ipd : std_ulogic := 'X';
   SIGNAL S_dly : std_ulogic := 'X';
   SIGNAL S_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( CLK_ipd, CLK, tipd_CLK );
   VitalWireDelay( D_ipd, D, tipd_D );
   VitalWireDelay( R_ipd, R, tipd_R );
   VitalWireDelay( S_ipd, S, tipd_S );
END BLOCK;

SIGNALDELAY : BLOCK
BEGIN
   VitalSignalDelay( CLK_dly, CLK_ipd, ticd_CLK );
   VitalSignalDelay( D_dly, D_ipd, tisd_D_CLK );
   VitalSignalDelay( R_dly, R_ipd, tisd_R_CLK );
   VitalSignalDelay( S_dly, S_ipd, tisd_S_CLK );
END BLOCK;

VITALBehavior : PROCESS (CLK_dly, D_dly, R_dly, S_dly)

      --timing checks section variables
      VARIABLE Tviol_rec_R_S_posedge : std_ulogic := '0';
      VARIABLE TimeMarker_rec_R_S_posedge : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE Tviol_rec_CLK_S_posedge : std_ulogic := '0';
      VARIABLE TimeMarker_rec_CLK_S_posedge : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE Tviol_rec_S_R_posedge : std_ulogic := '0';
      VARIABLE TimeMarker_rec_S_R_posedge : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE Tviol_rec_CLK_R_posedge : std_ulogic := '0';
      VARIABLE TimeMarker_rec_CLK_R_posedge : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE Tviol_D_CLK : std_ulogic := '0';
      VARIABLE TimeMarker_D_CLK : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE PWviol_S_negedge : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_S_negedge : VitalPeriodDataType;
      VARIABLE PWviol_R_negedge : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_R_negedge : VitalPeriodDataType;
      VARIABLE PWviol_CLK : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_CLK : VitalPeriodDataType;

      -- functionality section variables
      VARIABLE intclk : std_ulogic;
      VARIABLE n0_CLEAR : std_ulogic;
      VARIABLE n0_SET : std_ulogic;
      VARIABLE P0002 : std_ulogic;
      VARIABLE P0003 : std_ulogic;
      VARIABLE D_dly_t : std_ulogic;
      VARIABLE n0_vec : std_logic_vector( 1 TO 1 );
      VARIABLE PrevData_udp_dff_n0 : std_logic_vector( 0 TO 4 );
      VARIABLE Q_zd : std_ulogic;
      VARIABLE n1_cond : std_ulogic;
      VARIABLE n3_var : std_ulogic;
      VARIABLE n2_cond : std_ulogic;
      VARIABLE n4_cond : std_ulogic;
      VARIABLE NOTIFIER : std_ulogic := '0';

      -- path delay section variables
      VARIABLE Q_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Timing checks section
          IF (TimingChecksOn) THEN

                VitalRecoveryRemovalCheck (
                    TestSignal     => S_dly,
                    TestSignalName => "S",
                    RefSignal      => R_dly,
                    RefSignalName  => "R",
                    Recovery       => trecovery_S_R_posedge_posedge,
                    Removal        => tremoval_S_R_posedge_posedge,
                    CheckEnabled   => TRUE,
                    ActiveLow      => TRUE,
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFSR",
                    TimingData     => TimeMarker_rec_R_S_posedge,
                    Violation      => Tviol_rec_R_S_posedge,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalRecoveryRemovalCheck (
                    TestSignal     => S_dly,
                    TestSignalName => "S",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    Recovery       => trecovery_S_CLK_posedge_posedge,
                    Removal        => tremoval_S_CLK_posedge_posedge,
                    CheckEnabled   => To_X01(n2_cond) /= '0',
                    ActiveLow      => TRUE,
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFSR",
                    TimingData     => TimeMarker_rec_CLK_S_posedge,
                    Violation      => Tviol_rec_CLK_S_posedge,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalRecoveryRemovalCheck (
                    TestSignal     => R_dly,
                    TestSignalName => "R",
                    RefSignal      => S_dly,
                    RefSignalName  => "S",
                    Recovery       => trecovery_R_S_posedge_posedge,
                    Removal        => tremoval_R_S_posedge_posedge,
                    CheckEnabled   => TRUE,
                    ActiveLow      => TRUE,
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFSR",
                    TimingData     => TimeMarker_rec_S_R_posedge,
                    Violation      => Tviol_rec_S_R_posedge,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalRecoveryRemovalCheck (
                    TestSignal     => R_dly,
                    TestSignalName => "R",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    Recovery       => trecovery_R_CLK_posedge_posedge,
                    Removal        => tremoval_R_CLK_posedge_posedge,
                    CheckEnabled   => To_X01(n1_cond) /= '0',
                    ActiveLow      => TRUE,
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFSR",
                    TimingData     => TimeMarker_rec_CLK_R_posedge,
                    Violation      => Tviol_rec_CLK_R_posedge,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalSetupHoldCheck (
                    TestSignal     => D_dly,
                    TestSignalName => "D",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    SetupHigh      => tsetup_D_CLK_posedge_posedge,
                    SetupLow       => tsetup_D_CLK_negedge_posedge,
                    HoldHigh       => thold_D_CLK_negedge_posedge,
                    HoldLow        => thold_D_CLK_posedge_posedge,
                    CheckEnabled   => To_X01(n4_cond) /= '0',
                    RefTransition  => 'R',
                    HeaderMsg      => InstancePath & "/DFFSR",
                    TimingData     => TimeMarker_D_CLK,
                    Violation      => Tviol_D_CLK,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => S_dly,
                    TestSignalName => "S",
                    Period         => 0 ps,
                    PulseWidthHigh => 0 ns,
                    PulseWidthLow  => tpw_S_negedge,
                    PeriodData     => PeriodCheckInfo_S_negedge,
                    Violation      => PWviol_S_negedge,
                    HeaderMsg      => InstancePath & "/DFFSR",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => R_dly,
                    TestSignalName => "R",
                    Period         => 0 ps,
                    PulseWidthHigh => 0 ns,
                    PulseWidthLow  => tpw_R_negedge,
                    PeriodData     => PeriodCheckInfo_R_negedge,
                    Violation      => PWviol_R_negedge,
                    HeaderMsg      => InstancePath & "/DFFSR",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => CLK_dly,
                    TestSignalName => "CLK",
                    Period         => 0 ps,
                    PulseWidthHigh => tpw_CLK_posedge,
                    PulseWidthLow  => tpw_CLK_negedge,
                    PeriodData     => PeriodCheckInfo_CLK,
                    Violation      => PWviol_CLK,
                    HeaderMsg      => InstancePath & "/DFFSR",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

          END IF;


          -- Functionality section
          NOTIFIER := (
                        Tviol_rec_R_S_posedge OR
                        Tviol_rec_CLK_S_posedge OR
                        Tviol_rec_S_R_posedge OR
                        Tviol_rec_CLK_R_posedge OR
                        Tviol_D_CLK OR
                        PWviol_S_negedge OR
                        PWviol_R_negedge OR
                        PWviol_CLK );

          intclk := VitalBUF(CLK_dly);

          n0_CLEAR := VitalINV(R_dly);

          n0_SET := VitalINV(S_dly);

          D_dly_t := VitalINV(D_dly);

          VitalStateTable ( StateTable => udp_dff,
                                DataIn => (NOTIFIER, D_dly_t, intclk, n0_SET, n0_CLEAR),
                             NumStates => 1,
                                Result => n0_vec,
                        PreviousDataIn => PrevData_udp_dff_n0 );

          P0003 := n0_vec(1);

          P0002 := VitalINV(P0003);

          Q_zd := VitalBUF(P0002);

          n1_cond := VitalAND2(D_dly, S_dly);

          n3_var := VitalINV(D_dly);
          n2_cond := VitalAND2(n3_var, R_dly);

          n4_cond := VitalAND2(S_dly, R_dly);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Q,
               OutSignalName => "Q",
               OutTemp => Q_zd,
               Paths => (
                      0 => ( CLK_dly'LAST_EVENT,
                             tpd_CLK_Q,
                             TRUE),
                      1 => ( R_dly'LAST_EVENT,
                             tpd_R_Q,
                             TRUE),
                      2 => ( S_dly'LAST_EVENT,
                             tpd_S_Q,
                             TRUE)),
               GlitchData => Q_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity FAX1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_YC : VitalDelayType01 := (0.242292 ns, 0.269289 ns);
             tpd_A_YS : VitalDelayType01 := (0.362431 ns, 0.383533 ns);
             tpd_B_YC : VitalDelayType01 := (0.252597 ns, 0.280266 ns);
             tpd_B_YS : VitalDelayType01 := (0.382649 ns, 0.398666 ns);
             tpd_C_YC : VitalDelayType01 := (0.233744 ns, 0.260837 ns);
             tpd_C_YS : VitalDelayType01 := (0.37741 ns, 0.375669 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         YC : out std_ulogic ;
         YS : out std_ulogic);

   attribute VITAL_LEVEL0 of FAX1 : entity is TRUE;
end FAX1;

architecture behavioral of FAX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE n2_var : std_ulogic;
      VARIABLE n3_var : std_ulogic;
      VARIABLE YC_zd : std_ulogic;
      VARIABLE n4_var : std_ulogic;
      VARIABLE YS_zd : std_ulogic;

      -- path delay section variables
      VARIABLE YC_GlitchData : VitalGlitchDataType;
      VARIABLE YS_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalAND2(A_ipd, B_ipd);
          n1_var := VitalAND2(B_ipd, C_ipd);
          n2_var := VitalOR2(n0_var, n1_var);
          n3_var := VitalAND2(C_ipd, A_ipd);
          YC_zd := VitalOR2(n2_var, n3_var);

          n4_var := VitalXOR2(A_ipd, B_ipd);
          YS_zd := VitalXOR2(n4_var, C_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => YC,
               OutSignalName => "YC",
               OutTemp => YC_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_YC,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_YC,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_YC,
                             TRUE)),
               GlitchData => YC_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );

          VitalPathDelay01(
               OutSignal     => YS,
               OutSignalName => "YS",
               OutTemp => YS_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_YS,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_YS,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_YS,
                             TRUE)),
               GlitchData => YS_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity HAX1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_YC : VitalDelayType01 := (0.176848 ns, 0.234103 ns);
             tpd_A_YS : VitalDelayType01 := (0.266939 ns, 0.315483 ns);
             tpd_B_YC : VitalDelayType01 := (0.174874 ns, 0.21535 ns);
             tpd_B_YS : VitalDelayType01 := (0.274678 ns, 0.314653 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         YC : out std_ulogic ;
         YS : out std_ulogic);

   attribute VITAL_LEVEL0 of HAX1 : entity is TRUE;
end HAX1;

architecture behavioral of HAX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE YC_zd : std_ulogic;
      VARIABLE YS_zd : std_ulogic;

      -- path delay section variables
      VARIABLE YC_GlitchData : VitalGlitchDataType;
      VARIABLE YS_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          YC_zd := VitalAND2(A_ipd, B_ipd);

          YS_zd := VitalXOR2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => YC,
               OutSignalName => "YC",
               OutTemp => YC_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_YC,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_YC,
                             TRUE)),
               GlitchData => YC_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );

          VitalPathDelay01(
               OutSignal     => YS,
               OutSignalName => "YS",
               OutTemp => YS_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_YS,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_YS,
                             TRUE)),
               GlitchData => YS_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity INVX1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.0809571 ns, 0.0908982 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of INVX1 : entity is TRUE;
end INVX1;

architecture behavioral of INVX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalINV(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity INVX2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.0794573 ns, 0.0832355 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of INVX2 : entity is TRUE;
end INVX2;

architecture behavioral of INVX2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalINV(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity INVX4 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.0794573 ns, 0.0832355 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of INVX4 : entity is TRUE;
end INVX4;

architecture behavioral of INVX4 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalINV(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity INVX8 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.0794573 ns, 0.0832355 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of INVX8 : entity is TRUE;
end INVX8;

architecture behavioral of INVX8 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
END BLOCK;

VITALBehavior : PROCESS (A_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalINV(A_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity LATCH is
   generic (
             tipd_CLK : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             ticd_CLK : VitalDelayType := DefDummyIcd;
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tisd_D_CLK : VitalDelayType := DefDummyIsd;
             tsetup_D_CLK_posedge_negedge : VitalDelayType := 0.375 ns;
             tsetup_D_CLK_negedge_negedge : VitalDelayType := 0.28125 ns;
             thold_D_CLK_posedge_negedge : VitalDelayType := -0.1875 ns;
             thold_D_CLK_negedge_negedge : VitalDelayType := -0.0937499 ns;
             tpw_CLK_posedge : VitalDelayType := 0.241222 ns;
             tpd_CLK_Q : VitalDelayType01 := (0.291301 ns, 0.379079 ns);
             tpd_D_Q : VitalDelayType01 := (0.354606 ns, 0.367567 ns);

             TimingChecksOn : BOOLEAN := false;
             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         CLK : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         Q : out std_ulogic);

   attribute VITAL_LEVEL0 of LATCH : entity is TRUE;
end LATCH;

architecture behavioral of LATCH is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL CLK_dly : std_ulogic := 'X';
   SIGNAL CLK_ipd : std_ulogic := 'X';
   SIGNAL D_dly : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( CLK_ipd, CLK, tipd_CLK );
   VitalWireDelay( D_ipd, D, tipd_D );
END BLOCK;

SIGNALDELAY : BLOCK
BEGIN
   VitalSignalDelay( CLK_dly, CLK_ipd, ticd_CLK );
   VitalSignalDelay( D_dly, D_ipd, tisd_D_CLK );
END BLOCK;

VITALBehavior : PROCESS (CLK_dly, D_dly)

      --timing checks section variables
      VARIABLE Tviol_D_CLK : std_ulogic := '0';
      VARIABLE TimeMarker_D_CLK : VitalTimingDataType := VitalTimingDataInit;
      VARIABLE PWviol_CLK_posedge : std_ulogic := '0';
      VARIABLE PeriodCheckInfo_CLK_posedge : VitalPeriodDataType;

      -- functionality section variables
      VARIABLE n0_RN_dly : std_ulogic := '0';
      VARIABLE n0_SN_dly : std_ulogic := '0';
      VARIABLE DS0000 : std_ulogic;
      VARIABLE P0000 : std_ulogic;
      VARIABLE n0_vec : std_logic_vector( 1 TO 1 );
      VARIABLE PrevData_udp_tlat_n0 : std_logic_vector( 0 TO 4 );
      VARIABLE Q_zd : std_ulogic;
      VARIABLE NOTIFIER : std_ulogic := '0';

      -- path delay section variables
      VARIABLE Q_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Timing checks section
          IF (TimingChecksOn) THEN

                VitalSetupHoldCheck (
                    TestSignal     => D_dly,
                    TestSignalName => "D",
                    RefSignal      => CLK_dly,
                    RefSignalName  => "CLK",
                    SetupHigh      => tsetup_D_CLK_posedge_negedge,
                    SetupLow       => tsetup_D_CLK_negedge_negedge,
                    HoldHigh       => thold_D_CLK_negedge_negedge,
                    HoldLow        => thold_D_CLK_posedge_negedge,
                    CheckEnabled   => TRUE,
                    RefTransition  => 'F',
                    HeaderMsg      => InstancePath & "/LATCH",
                    TimingData     => TimeMarker_D_CLK,
                    Violation      => Tviol_D_CLK,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

                VitalPeriodPulseCheck (
                    TestSignal     => CLK_dly,
                    TestSignalName => "CLK",
                    Period         => 0 ps,
                    PulseWidthHigh => tpw_CLK_posedge,
                    PulseWidthLow  => 0 ns,
                    PeriodData     => PeriodCheckInfo_CLK_posedge,
                    Violation      => PWviol_CLK_posedge,
                    HeaderMsg      => InstancePath & "/LATCH",
                    CheckEnabled   => TRUE,
                    XOn            => DefSeqXOn,
                    MsgOn          => DefSeqMsgOn,
                    MsgSeverity    => WARNING );

          END IF;


          -- Functionality section
          NOTIFIER := (
                        Tviol_D_CLK OR
                        PWviol_CLK_posedge );

          n0_RN_dly := '0';

          n0_SN_dly := '0';

          VitalStateTable ( StateTable => udp_tlat,
                                DataIn => (NOTIFIER, D_dly, CLK_dly, n0_RN_dly, n0_SN_dly),
                             NumStates => 1,
                                Result => n0_vec,
                        PreviousDataIn => PrevData_udp_tlat_n0 );

          DS0000 := n0_vec(1);

          P0000 := VitalINV(DS0000);

          Q_zd := VitalBUF(DS0000);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Q,
               OutSignalName => "Q",
               OutTemp => Q_zd,
               Paths => (
                      0 => ( CLK_dly'LAST_EVENT,
                             tpd_CLK_Q,
                             TRUE),
                      1 => ( D_dly'LAST_EVENT,
                             tpd_D_Q,
                             TRUE)),
               GlitchData => Q_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity MUX2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_S : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.130958 ns, 0.105022 ns);
             tpd_B_Y : VitalDelayType01 := (0.118089 ns, 0.117626 ns);
             tpd_S_Y : VitalDelayType01 := (0.205605 ns, 0.199127 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         S : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of MUX2X1 : entity is TRUE;
end MUX2X1;

architecture behavioral of MUX2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL S_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( S_ipd, S, tipd_S );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, S_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalMUX2(A_ipd, B_ipd, S_ipd);
          Y_zd := VitalINV(n0_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( S_ipd'LAST_EVENT,
                             tpd_S_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity NAND2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.103824 ns, 0.0710613 ns);
             tpd_B_Y : VitalDelayType01 := (0.0921573 ns, 0.0718746 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of NAND2X1 : entity is TRUE;
end NAND2X1;

architecture behavioral of NAND2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalAND2(A_ipd, B_ipd);
          Y_zd := VitalINV(n0_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity NAND3X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.145957 ns, 0.0781289 ns);
             tpd_B_Y : VitalDelayType01 := (0.126844 ns, 0.0763875 ns);
             tpd_C_Y : VitalDelayType01 := (0.101279 ns, 0.0650131 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of NAND3X1 : entity is TRUE;
end NAND3X1;

architecture behavioral of NAND3X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalAND2(A_ipd, B_ipd);
          n1_var := VitalAND2(n0_var, C_ipd);
          Y_zd := VitalINV(n1_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity NOR2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.0934715 ns, 0.150074 ns);
             tpd_B_Y : VitalDelayType01 := (0.0860717 ns, 0.116136 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of NOR2X1 : entity is TRUE;
end NOR2X1;

architecture behavioral of NOR2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalOR2(A_ipd, B_ipd);
          Y_zd := VitalINV(n0_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity NOR3X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.134381 ns, 0.240857 ns);
             tpd_B_Y : VitalDelayType01 := (0.122952 ns, 0.202035 ns);
             tpd_C_Y : VitalDelayType01 := (0.0856614 ns, 0.135743 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of NOR3X1 : entity is TRUE;
end NOR3X1;

architecture behavioral of NOR3X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalOR2(A_ipd, B_ipd);
          n1_var := VitalOR2(n0_var, C_ipd);
          Y_zd := VitalINV(n1_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity OAI21X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.118532 ns, 0.110401 ns);
             tpd_B_Y : VitalDelayType01 := (0.106728 ns, 0.0889442 ns);
             tpd_C_Y : VitalDelayType01 := (0.0987512 ns, 0.0822925 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of OAI21X1 : entity is TRUE;
end OAI21X1;

architecture behavioral of OAI21X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalOR2(A_ipd, B_ipd);
          n1_var := VitalAND2(n0_var, C_ipd);
          Y_zd := VitalINV(n1_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity OAI22X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_C : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_D : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.131748 ns, 0.123608 ns);
             tpd_B_Y : VitalDelayType01 := (0.121859 ns, 0.104778 ns);
             tpd_C_Y : VitalDelayType01 := (0.112429 ns, 0.119006 ns);
             tpd_D_Y : VitalDelayType01 := (0.102059 ns, 0.100185 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         C : in std_ulogic := 'U' ;
         D : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of OAI22X1 : entity is TRUE;
end OAI22X1;

architecture behavioral of OAI22X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';
   SIGNAL C_ipd : std_ulogic := 'X';
   SIGNAL D_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
   VitalWireDelay( C_ipd, C, tipd_C );
   VitalWireDelay( D_ipd, D, tipd_D );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd, C_ipd, D_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE n1_var : std_ulogic;
      VARIABLE n2_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalOR2(A_ipd, B_ipd);
          n1_var := VitalOR2(C_ipd, D_ipd);
          n2_var := VitalAND2(n0_var, n1_var);
          Y_zd := VitalINV(n2_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE),
                      2 => ( C_ipd'LAST_EVENT,
                             tpd_C_Y,
                             TRUE),
                      3 => ( D_ipd'LAST_EVENT,
                             tpd_D_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity OR2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.168124 ns, 0.167235 ns);
             tpd_B_Y : VitalDelayType01 := (0.217882 ns, 0.178768 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of OR2X1 : entity is TRUE;
end OR2X1;

architecture behavioral of OR2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalOR2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity OR2X2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.21564 ns, 0.192162 ns);
             tpd_B_Y : VitalDelayType01 := (0.26144 ns, 0.199666 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of OR2X2 : entity is TRUE;
end OR2X2;

architecture behavioral of OR2X2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalOR2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity PADINC is
   generic (
             tipd_YPAD : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_YPAD_DI : VitalDelayType01 := (0.108026 ns, 0.115822 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         YPAD : in std_ulogic := 'U' ;
         DI : out std_ulogic);

   attribute VITAL_LEVEL0 of PADINC : entity is TRUE;
end PADINC;

architecture behavioral of PADINC is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL YPAD_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( YPAD_ipd, YPAD, tipd_YPAD );
END BLOCK;

VITALBehavior : PROCESS (YPAD_ipd)


      -- functionality section variables
      VARIABLE DI_zd : std_ulogic;

      -- path delay section variables
      VARIABLE DI_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          DI_zd := VitalBUF(YPAD_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => DI,
               OutSignalName => "DI",
               OutTemp => DI_zd,
               Paths => (
                      0 => ( YPAD_ipd'LAST_EVENT,
                             tpd_YPAD_DI,
                             TRUE)),
               GlitchData => DI_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity PADINOUT is
   generic (
             tipd_DO : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_OEN : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_YPAD : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_DO_YPAD : VitalDelayType01 := (0.693264 ns, 0.50214 ns);
             tpd_OEN_YPAD : VitalDelayType01Z := (VitalZeroDelay, VitalZeroDelay, 0.486388 ns, 0.86038 ns, 0.619694 ns, 0.558941 ns);
             tpd_YPAD_DI : VitalDelayType01 := (0.107478 ns, 0.115822 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         DO : in std_ulogic := 'U' ;
         OEN : in std_ulogic := 'U' ;
         DI : out std_ulogic ;
         YPAD : inout std_ulogic);

   attribute VITAL_LEVEL0 of PADINOUT : entity is TRUE;
end PADINOUT;

architecture behavioral of PADINOUT is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL DO_ipd : std_ulogic := 'X';
   SIGNAL OEN_ipd : std_ulogic := 'X';
   SIGNAL YPAD_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( DO_ipd, DO, tipd_DO );
   VitalWireDelay( OEN_ipd, OEN, tipd_OEN );
   VitalWireDelay( YPAD_ipd, YPAD, tipd_YPAD );
END BLOCK;

VITALBehavior : PROCESS (DO_ipd, OEN_ipd, YPAD_ipd)


      -- functionality section variables
      VARIABLE YPAD_zd : std_ulogic;
      VARIABLE DI_zd : std_ulogic;

      -- path delay section variables
      VARIABLE DI_GlitchData : VitalGlitchDataType;
      VARIABLE YPAD_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          YPAD_zd := VitalBUFIF1(DO_ipd, OEN_ipd);

          DI_zd := VitalBUF(YPAD_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => DI,
               OutSignalName => "DI",
               OutTemp => DI_zd,
               Paths => (
                      0 => ( YPAD_ipd'LAST_EVENT,
                             tpd_YPAD_DI,
                             TRUE)),
               GlitchData => DI_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );

          VitalPathDelay01Z(
               OutSignal     => YPAD,
               OutSignalName => "YPAD",
               OutTemp => YPAD_zd,
               Paths => (
                      0 => ( DO_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_DO_YPAD),
                             TRUE),
                      1 => ( OEN_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_OEN_YPAD),
                             TRUE)),
               GlitchData => YPAD_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity PADOUT is
   generic (
             tipd_DO : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_DO_YPAD : VitalDelayType01 := (0.693264 ns, 0.50214 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         DO : in std_ulogic := 'U' ;
         YPAD : out std_ulogic);

   attribute VITAL_LEVEL0 of PADOUT : entity is TRUE;
end PADOUT;

architecture behavioral of PADOUT is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL DO_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( DO_ipd, DO, tipd_DO );
END BLOCK;

VITALBehavior : PROCESS (DO_ipd)


      -- functionality section variables
      VARIABLE YPAD_zd : std_ulogic;

      -- path delay section variables
      VARIABLE YPAD_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          YPAD_zd := VitalBUF(DO_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => YPAD,
               OutSignalName => "YPAD",
               OutTemp => YPAD_zd,
               Paths => (
                      0 => ( DO_ipd'LAST_EVENT,
                             tpd_DO_YPAD,
                             TRUE)),
               GlitchData => YPAD_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity TBUFX1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_EN : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.123226 ns, 0.0980208 ns);
             tpd_EN_Y : VitalDelayType01Z := (VitalZeroDelay, VitalZeroDelay, 0.0555 ns, 0.137042 ns, 0.106389 ns, 0.0528154 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         EN : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of TBUFX1 : entity is TRUE;
end TBUFX1;

architecture behavioral of TBUFX1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL EN_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( EN_ipd, EN, tipd_EN );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, EN_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalINV(A_ipd);
          Y_zd := VitalBUFIF1(n0_var, EN_ipd);


          -- Path delay section
          VitalPathDelay01Z(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_A_Y),
                             TRUE),
                      1 => ( EN_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_EN_Y),
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity TBUFX2 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_EN : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.121959 ns, 0.0989032 ns);
             tpd_EN_Y : VitalDelayType01Z := (VitalZeroDelay, VitalZeroDelay, 0.0555 ns, 0.130082 ns, 0.104296 ns, 0.0521681 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         EN : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of TBUFX2 : entity is TRUE;
end TBUFX2;

architecture behavioral of TBUFX2 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL EN_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( EN_ipd, EN, tipd_EN );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, EN_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalINV(A_ipd);
          Y_zd := VitalBUFIF1(n0_var, EN_ipd);


          -- Path delay section
          VitalPathDelay01Z(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_A_Y),
                             TRUE),
                      1 => ( EN_ipd'LAST_EVENT,
                             VitalExtendToFillDelay(tpd_EN_Y),
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity XNOR2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.156815 ns, 0.15237 ns);
             tpd_B_Y : VitalDelayType01 := (0.183189 ns, 0.17143 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of XNOR2X1 : entity is TRUE;
end XNOR2X1;

architecture behavioral of XNOR2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE n0_var : std_ulogic;
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          n0_var := VitalXOR2(A_ipd, B_ipd);
          Y_zd := VitalINV(n0_var);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;
USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;
USE work.prim.all;

entity XOR2X1 is
   generic (
             tipd_A : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tipd_B : VitalDelayType01 := (DefDummyIpd, DefDummyIpd);
             tpd_A_Y : VitalDelayType01 := (0.157363 ns, 0.152464 ns);
             tpd_B_Y : VitalDelayType01 := (0.17819 ns, 0.176759 ns);

             XOn            : BOOLEAN := DefCombSpikeXOn;
             MsgOn          : BOOLEAN := DefCombSpikeMsgOn;
             instancePath   : STRING  := "*" );

   port (
         A : in std_ulogic := 'U' ;
         B : in std_ulogic := 'U' ;
         Y : out std_ulogic);

   attribute VITAL_LEVEL0 of XOR2X1 : entity is TRUE;
end XOR2X1;

architecture behavioral of XOR2X1 is
   attribute VITAL_LEVEL1 of behavioral : architecture is TRUE;

   SIGNAL A_ipd : std_ulogic := 'X';
   SIGNAL B_ipd : std_ulogic := 'X';

begin

--Input Path Delays
WIREDELAY : BLOCK
BEGIN
   VitalWireDelay( A_ipd, A, tipd_A );
   VitalWireDelay( B_ipd, B, tipd_B );
END BLOCK;

VITALBehavior : PROCESS (A_ipd, B_ipd)


      -- functionality section variables
      VARIABLE Y_zd : std_ulogic;

      -- path delay section variables
      VARIABLE Y_GlitchData : VitalGlitchDataType;

      BEGIN
          -- Functionality section
          Y_zd := VitalXOR2(A_ipd, B_ipd);


          -- Path delay section
          VitalPathDelay01(
               OutSignal     => Y,
               OutSignalName => "Y",
               OutTemp => Y_zd,
               Paths => (
                      0 => ( A_ipd'LAST_EVENT,
                             tpd_A_Y,
                             TRUE),
                      1 => ( B_ipd'LAST_EVENT,
                             tpd_B_Y,
                             TRUE)),
               GlitchData => Y_GlitchData,
               Mode  => OnEvent,
               XOn            => XOn,
               MsgOn          => MsgOn,
               MsgSeverity    => WARNING );


END PROCESS;

end behavioral;


