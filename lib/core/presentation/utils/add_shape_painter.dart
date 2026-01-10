import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class AddShapePainter extends CustomPainter {
  final Color color;
  AddShapePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * -0.1074597, size.height * 0.4538302);
    path_0.cubicTo(
      size.width * -0.1100882,
      size.height * 0.4757401,
      size.width * -0.1169454,
      size.height * 0.4731481,
      size.width * -0.1225582,
      size.height * 0.4862877,
    );
    path_0.lineTo(size.width * -0.1133064, size.height * 0.4934907);
    path_0.cubicTo(
      size.width * -0.1114354,
      size.height * 0.5117235,
      size.width * -0.1260382,
      size.height * 0.5209148,
      size.width * -0.1353651,
      size.height * 0.5171481,
    );
    path_0.lineTo(size.width * -0.1384615, size.height * 0.5313123);
    path_0.lineTo(size.width * -0.1331574, size.height * 0.5275753);
    path_0.cubicTo(
      size.width * -0.1321282,
      size.height * 0.5477068,
      size.width * -0.1284800,
      size.height * 0.5308901,
      size.width * -0.1256736,
      size.height * 0.5329395,
    );
    path_0.cubicTo(
      size.width * -0.1260156,
      size.height * 0.5409284,
      size.width * -0.1261813,
      size.height * 0.5489846,
      size.width * -0.1261692,
      size.height * 0.5570488,
    );
    path_0.cubicTo(
      size.width * -0.1261692,
      size.height * 0.5593698,
      size.width * -0.1245136,
      size.height * 0.5628352,
      size.width * -0.1235592,
      size.height * 0.5630765,
    );
    path_0.cubicTo(
      size.width * -0.1223900,
      size.height * 0.5633778,
      size.width * -0.1211644,
      size.height * 0.5608463,
      size.width * -0.1192279,
      size.height * 0.5587068,
    );
    path_0.cubicTo(
      size.width * -0.1242795,
      size.height * 0.5728407,
      size.width * -0.1242795,
      size.height * 0.5728407,
      size.width * -0.1232413,
      size.height * 0.5801037,
    );
    path_0.lineTo(size.width * -0.1274323, size.height * 0.5888735);
    path_0.cubicTo(
      size.width * -0.1265436,
      size.height * 0.5938463,
      size.width * -0.1258418,
      size.height * 0.5977340,
      size.width * -0.1250562,
      size.height * 0.6020735,
    );
    path_0.lineTo(size.width * -0.1165244, size.height * 0.5879395);
    path_0.lineTo(size.width * -0.1159913, size.height * 0.5909531);
    path_0.lineTo(size.width * -0.1205003, size.height * 0.6020432);
    path_0.lineTo(size.width * -0.1175628, size.height * 0.6149420);
    path_0.cubicTo(
      size.width * -0.1200513,
      size.height * 0.6197654,
      size.width * -0.1220626,
      size.height * 0.6247037,
      size.width * -0.1242890,
      size.height * 0.6277469,
    );
    path_0.cubicTo(
      size.width * -0.1276379,
      size.height * 0.6323025,
      size.width * -0.1283956,
      size.height * 0.6382099,
      size.width * -0.1260382,
      size.height * 0.6451111,
    );
    path_0.lineTo(size.width * -0.1196210, size.height * 0.6533951);
    path_0.lineTo(size.width * -0.1149436, size.height * 0.6397160);
    path_0.cubicTo(
      size.width * -0.1130726,
      size.height * 0.6791605,
      size.width * -0.1055887,
      size.height * 0.6692160,
      size.width * -0.09769308,
      size.height * 0.6632840,
    );
    path_0.cubicTo(
      size.width * -0.09818897,
      size.height * 0.6706667,
      size.width * -0.09862872,
      size.height * 0.6767531,
      size.width * -0.09899359,
      size.height * 0.6828395,
    );
    path_0.cubicTo(
      size.width * -0.09825436,
      size.height * 0.6880864,
      size.width * -0.09856308,
      size.height * 0.6934753,
      size.width * -0.09817974,
      size.height * 0.6982407,
    );
    path_0.cubicTo(
      size.width * -0.09750615,
      size.height * 0.7067963,
      size.width * -0.09609359,
      size.height * 0.7223519,
      size.width * -0.09556026,
      size.height * 0.7221358,
    );
    path_0.cubicTo(
      size.width * -0.09202410,
      size.height * 0.7203333,
      size.width * -0.09141615,
      size.height * 0.7314198,
      size.width * -0.08923641,
      size.height * 0.7345247,
    );
    path_0.lineTo(size.width * -0.09484923, size.height * 0.7572778);
    path_0.lineTo(size.width * -0.08897436, size.height * 0.7813889);
    path_0.lineTo(size.width * -0.08991000, size.height * 0.7851235);
    path_0.lineTo(size.width * -0.08657974, size.height * 0.7948580);
    path_0.lineTo(size.width * -0.09328692, size.height * 0.8099259);
    path_0.cubicTo(
      size.width * -0.09328692,
      size.height * 0.8112222,
      size.width * -0.09328692,
      size.height * 0.8125185,
      size.width * -0.09328692,
      size.height * 0.8138148,
    );
    path_0.lineTo(size.width * -0.08645795, size.height * 0.8156852);
    path_0.cubicTo(
      size.width * -0.08645795,
      size.height * 0.8156852,
      size.width * -0.08601846,
      size.height * 0.8183642,
      size.width * -0.08565359,
      size.height * 0.8206543,
    );
    path_0.lineTo(size.width * -0.08857231, size.height * 0.8312346);
    path_0.cubicTo(
      size.width * -0.08419410,
      size.height * 0.8361173,
      size.width * -0.08108846,
      size.height * 0.8314753,
      size.width * -0.07854385,
      size.height * 0.8175802,
    );
    path_0.lineTo(size.width * -0.07343615, size.height * 0.8185185);
    path_0.lineTo(size.width * -0.07920795, size.height * 0.8312346);
    path_0.lineTo(size.width * -0.07733718, size.height * 0.8393704);
    path_0.lineTo(size.width * -0.08167769, size.height * 0.8488333);
    path_0.cubicTo(
      size.width * -0.07974128,
      size.height * 0.8509136,
      size.width * -0.07887128,
      size.height * 0.8520864,
      size.width * -0.07800128,
      size.height * 0.8526605,
    );
    path_0.cubicTo(
      size.width * -0.07713128,
      size.height * 0.8532346,
      size.width * -0.07601795,
      size.height * 0.8534136,
      size.width * -0.07409103,
      size.height * 0.8540802,
    );
    path_0.lineTo(size.width * -0.07814154, size.height * 0.8635123);
    path_0.cubicTo(
      size.width * -0.07546615,
      size.height * 0.8755679,
      size.width * -0.07204231,
      size.height * 0.8732716,
      size.width * -0.06758000,
      size.height * 0.8566667,
    );
    path_0.lineTo(size.width * -0.06364154, size.height * 0.8614630);
    path_0.cubicTo(
      size.width * -0.06357564,
      size.height * 0.8634074,
      size.width * -0.06338436,
      size.height * 0.8652901,
      size.width * -0.06307974,
      size.height * 0.8669877,
    );
    path_0.cubicTo(
      size.width * -0.06277538,
      size.height * 0.8686852,
      size.width * -0.06236462,
      size.height * 0.8701605,
      size.width * -0.06187359,
      size.height * 0.8713148,
    );
    path_0.cubicTo(
      size.width * -0.06000256,
      size.height * 0.8747531,
      size.width * -0.05743923,
      size.height * 0.8756235,
      size.width * -0.05613897,
      size.height * 0.8805679,
    );
    path_0.cubicTo(
      size.width * -0.05447385,
      size.height * 0.8868642,
      size.width * -0.05325769,
      size.height * 0.8878025,
      size.width * -0.05116231,
      size.height * 0.8844259,
    );
    path_0.cubicTo(
      size.width * -0.04414615,
      size.height * 0.8730617,
      size.width * -0.03699897,
      size.height * 0.8774938,
      size.width * -0.02987051,
      size.height * 0.8816235,
    );
    path_0.cubicTo(
      size.width * -0.02987051,
      size.height * 0.8827963,
      size.width * -0.02987051,
      size.height * 0.8840062,
      size.width * -0.02980513,
      size.height * 0.8851790,
    );
    path_0.lineTo(size.width * -0.03714872, size.height * 0.8851790);
    path_0.cubicTo(
      size.width * -0.03759769,
      size.height * 0.8912037,
      size.width * -0.03792513,
      size.height * 0.8955432,
      size.width * -0.03862667,
      size.height * 0.9048889,
    );
    path_0.lineTo(size.width * -0.03430487, size.height * 0.8978333);
    path_0.lineTo(size.width * -0.03298590, size.height * 0.9028395);
    path_0.lineTo(size.width * -0.03794385, size.height * 0.9232099);
    path_0.lineTo(size.width * -0.03591385, size.height * 0.9265556);
    path_0.lineTo(size.width * -0.04102154, size.height * 0.9512099);
    path_0.cubicTo(
      size.width * -0.03575487,
      size.height * 0.9525370,
      size.width * -0.03377154,
      size.height * 0.9405679,
      size.width * -0.03155462,
      size.height * 0.9317099,
    );
    path_0.cubicTo(
      size.width * -0.02968359,
      size.height * 0.9243889,
      size.width * -0.02929051,
      size.height * 0.9232407,
      size.width * -0.02704538,
      size.height * 0.9298704,
    );
    path_0.cubicTo(
      size.width * -0.02848615,
      size.height * 0.9375247,
      size.width * -0.02985179,
      size.height * 0.9449383,
      size.width * -0.03129256,
      size.height * 0.9525617,
    );
    path_0.cubicTo(
      size.width * -0.03093718,
      size.height * 0.9538580,
      size.width * -0.03059103,
      size.height * 0.9551852,
      size.width * -0.03023538,
      size.height * 0.9565123,
    );
    path_0.cubicTo(
      size.width * -0.02872000,
      size.height * 0.9527778,
      size.width * -0.02688641,
      size.height * 0.9498827,
      size.width * -0.02577333,
      size.height * 0.9450617,
    );
    path_0.cubicTo(
      size.width * -0.02466000,
      size.height * 0.9402407,
      size.width * -0.02429515,
      size.height * 0.9334568,
      size.width * -0.02352805,
      size.height * 0.9269815,
    );
    path_0.cubicTo(
      size.width * -0.02089000,
      size.height * 0.9376790,
      size.width * -0.02037546,
      size.height * 0.9379753,
      size.width * -0.01510869,
      size.height * 0.9330062,
    );
    path_0.cubicTo(
      size.width * -0.01636226,
      size.height * 0.9503333,
      size.width * -0.01762515,
      size.height * 0.9676605,
      size.width * -0.01906579,
      size.height * 0.9874321,
    );
    path_0.cubicTo(
      size.width * -0.01451000,
      size.height * 0.9848086,
      size.width * -0.01304128,
      size.height * 0.9749259,
      size.width * -0.01201226,
      size.height * 0.9646173,
    );
    path_0.cubicTo(
      size.width * -0.007203872,
      size.height * 0.9701049,
      size.width * -0.008130000,
      size.height * 0.9501235,
      size.width * -0.004996128,
      size.height * 0.9470494,
    );
    path_0.lineTo(size.width * -0.001338385, size.height * 0.9517840);
    path_0.cubicTo(
      size.width * -0.005510641,
      size.height * 0.9588642,
      size.width * -0.003443231,
      size.height * 0.9638333,
      size.width * -0.001937095,
      size.height * 0.9668519,
    );
    path_0.cubicTo(
      size.width * -0.002797744,
      size.height * 0.9777593,
      size.width * -0.003555487,
      size.height * 0.9872531,
      size.width * -0.004575154,
      size.height,
    );
    path_0.cubicTo(
      size.width * 0.0005887026,
      size.height * 0.9909568,
      size.width * 0.001617746,
      size.height * 0.9790556,
      size.width * 0.001150003,
      size.height * 0.9648025,
    );
    path_0.lineTo(size.width * 0.006192256, size.height * 0.9548272);
    path_0.cubicTo(
      size.width * 0.005733872,
      size.height * 0.9513272,
      size.width * 0.005378385,
      size.height * 0.9485556,
      size.width * 0.005022897,
      size.height * 0.9457840,
    );
    path_0.lineTo(size.width * 0.005659026, size.height * 0.9434321);
    path_0.lineTo(size.width * 0.01072933, size.height * 0.9550370);
    path_0.lineTo(size.width * 0.01634226, size.height * 0.9411728);
    path_0.cubicTo(
      size.width * 0.01617385,
      size.height * 0.9515370,
      size.width * 0.01603354,
      size.height * 0.9602222,
      size.width * 0.01585579,
      size.height * 0.9716728,
    );
    path_0.cubicTo(
      size.width * 0.02074838,
      size.height * 0.9615741,
      size.width * 0.02014967,
      size.height * 0.9490679,
      size.width * 0.01948546,
      size.height * 0.9394259,
    );
    path_0.lineTo(size.width * 0.02410677, size.height * 0.9162222);
    path_0.cubicTo(
      size.width * 0.02449967,
      size.height * 0.9167901,
      size.width * 0.02580000,
      size.height * 0.9204383,
      size.width * 0.02664205,
      size.height * 0.9194753,
    );
    path_0.cubicTo(
      size.width * 0.02812000,
      size.height * 0.9177593,
      size.width * 0.03051487,
      size.height * 0.9126914,
      size.width * 0.03038385,
      size.height * 0.9099506,
    );
    path_0.cubicTo(
      size.width * 0.02988795,
      size.height * 0.8967840,
      size.width * 0.03187128,
      size.height * 0.8955185,
      size.width * 0.03430359,
      size.height * 0.8963580,
    );
    path_0.lineTo(size.width * 0.03827000, size.height * 0.8670370);
    path_0.lineTo(size.width * 0.05074923, size.height * 0.9235741);
    path_0.cubicTo(
      size.width * 0.05610974,
      size.height * 0.9018765,
      size.width * 0.05314410,
      size.height * 0.8822222,
      size.width * 0.05193744,
      size.height * 0.8617346,
    );
    path_0.lineTo(size.width * 0.06950564, size.height * 0.9119383);
    path_0.cubicTo(
      size.width * 0.07418308,
      size.height * 0.8973519,
      size.width * 0.06776564,
      size.height * 0.8894568,
      size.width * 0.06774718,
      size.height * 0.8767407,
    );
    path_0.lineTo(size.width * 0.07977744, size.height * 0.9101296);
    path_0.cubicTo(
      size.width * 0.08385615,
      size.height * 0.9050370,
      size.width * 0.08118051,
      size.height * 0.8976235,
      size.width * 0.08050718,
      size.height * 0.8920494,
    );
    path_0.cubicTo(
      size.width * 0.07962436,
      size.height * 0.8859444,
      size.width * 0.07859513,
      size.height * 0.8800679,
      size.width * 0.07742923,
      size.height * 0.8744815,
    );
    path_0.lineTo(size.width * 0.07810282, size.height * 0.8714691);
    path_0.cubicTo(
      size.width * 0.08057256,
      size.height * 0.8797840,
      size.width * 0.08278026,
      size.height * 0.8766173,
      size.width * 0.08567103,
      size.height * 0.8742963,
    );
    path_0.cubicTo(
      size.width * 0.08915103,
      size.height * 0.8714938,
      size.width * 0.09315487,
      size.height * 0.8759877,
      size.width * 0.09689667,
      size.height * 0.8767407,
    );
    path_0.cubicTo(
      size.width * 0.09975923,
      size.height * 0.8773148,
      size.width * 0.1026313,
      size.height * 0.8765000,
      size.width * 0.1054844,
      size.height * 0.8771296,
    );
    path_0.cubicTo(
      size.width * 0.1098156,
      size.height * 0.8780679,
      size.width * 0.1141285,
      size.height * 0.8803272,
      size.width * 0.1184597,
      size.height * 0.8809568,
    );
    path_0.cubicTo(
      size.width * 0.1252138,
      size.height * 0.8819815,
      size.width * 0.1319679,
      size.height * 0.8821975,
      size.width * 0.1387221,
      size.height * 0.8826173,
    );
    path_0.cubicTo(
      size.width * 0.1439049,
      size.height * 0.8829198,
      size.width * 0.1491154,
      size.height * 0.8840309,
      size.width * 0.1542792,
      size.height * 0.8829506,
    );
    path_0.cubicTo(
      size.width * 0.1637492,
      size.height * 0.8804568,
      size.width * 0.1732797,
      size.height * 0.8819136,
      size.width * 0.1826338,
      size.height * 0.8872901,
    );
    path_0.cubicTo(
      size.width * 0.1857864,
      size.height * 0.8892778,
      size.width * 0.1891821,
      size.height * 0.8880432,
      size.width * 0.1924095,
      size.height * 0.8870494,
    );
    path_0.cubicTo(
      size.width * 0.1963013,
      size.height * 0.8858086,
      size.width * 0.2004733,
      size.height * 0.8790926,
      size.width * 0.2039628,
      size.height * 0.8821667,
    );
    path_0.cubicTo(
      size.width * 0.2103241,
      size.height * 0.8878580,
      size.width * 0.2162456,
      size.height * 0.8803580,
      size.width * 0.2223169,
      size.height * 0.8798148,
    );
    path_0.cubicTo(
      size.width * 0.2293238,
      size.height * 0.8791543,
      size.width * 0.2362651,
      size.height * 0.8700802,
      size.width * 0.2433559,
      size.height * 0.8785185,
    );
    path_0.cubicTo(
      size.width * 0.2437490,
      size.height * 0.8789691,
      size.width * 0.2442915,
      size.height * 0.8799938,
      size.width * 0.2445533,
      size.height * 0.8794506,
    );
    path_0.cubicTo(
      size.width * 0.2506903,
      size.height * 0.8653457,
      size.width * 0.2579872,
      size.height * 0.8802037,
      size.width * 0.2643769,
      size.height * 0.8699877,
    );
    path_0.cubicTo(
      size.width * 0.2671821,
      size.height * 0.8655000,
      size.width * 0.2704667,
      size.height * 0.8645062,
      size.width * 0.2735359,
      size.height * 0.8619444,
    );
    path_0.cubicTo(
      size.width * 0.2776692,
      size.height * 0.8615802,
      size.width * 0.2818795,
      size.height * 0.8596235,
      size.width * 0.2861077,
      size.height * 0.8585370,
    );
    path_0.cubicTo(
      size.width * 0.2893256,
      size.height * 0.8577222,
      size.width * 0.2925615,
      size.height * 0.8582963,
      size.width * 0.2957795,
      size.height * 0.8576914,
    );
    path_0.cubicTo(
      size.width * 0.2969692,
      size.height * 0.8572593,
      size.width * 0.2981308,
      size.height * 0.8562407,
      size.width * 0.2992231,
      size.height * 0.8546790,
    );
    path_0.cubicTo(
      size.width * 0.3029641,
      size.height * 0.8500988,
      size.width * 0.3068846,
      size.height * 0.8401235,
      size.width * 0.3102718,
      size.height * 0.8419938,
    );
    path_0.cubicTo(
      size.width * 0.3139667,
      size.height * 0.8440432,
      size.width * 0.3170615,
      size.height * 0.8403951,
      size.width * 0.3204308,
      size.height * 0.8402469,
    );
    path_0.cubicTo(
      size.width * 0.3220462,
      size.height * 0.8400556,
      size.width * 0.3236359,
      size.height * 0.8415494,
      size.width * 0.3249667,
      size.height * 0.8444938,
    );
    path_0.cubicTo(
      size.width * 0.3315821,
      size.height * 0.8613704,
      size.width * 0.3384487,
      size.height * 0.8744506,
      size.width * 0.3471769,
      size.height * 0.8721605,
    );
    path_0.cubicTo(
      size.width * 0.3488692,
      size.height * 0.8717099,
      size.width * 0.3507026,
      size.height * 0.8772531,
      size.width * 0.3524615,
      size.height * 0.8799938,
    );
    path_0.cubicTo(
      size.width * 0.3523590,
      size.height * 0.8811728,
      size.width * 0.3522462,
      size.height * 0.8823148,
      size.width * 0.3521436,
      size.height * 0.8834630,
    );
    path_0.lineTo(size.width * 0.3641077, size.height * 0.8815000);
    path_0.lineTo(size.width * 0.3631718, size.height * 0.8743580);
    path_0.cubicTo(
      size.width * 0.3671026,
      size.height * 0.8722222,
      size.width * 0.3690487,
      size.height * 0.8780988,
      size.width * 0.3692718,
      size.height * 0.8900926,
    );
    path_0.cubicTo(
      size.width * 0.3730128,
      size.height * 0.8921975,
      size.width * 0.3763718,
      size.height * 0.8931049,
      size.width * 0.3777846,
      size.height * 0.8767407,
    );
    path_0.cubicTo(
      size.width * 0.3812000,
      size.height * 0.8962407,
      size.width * 0.3848103,
      size.height * 0.8783951,
      size.width * 0.3885513,
      size.height * 0.8785494,
    );
    path_0.lineTo(size.width * 0.3860538, size.height * 0.8906049);
    path_0.cubicTo(
      size.width * 0.3914154,
      size.height * 0.9036543,
      size.width * 0.3958769,
      size.height * 0.8980802,
      size.width * 0.3998436,
      size.height * 0.8832469,
    );
    path_0.cubicTo(
      size.width * 0.4017154,
      size.height * 0.9013333,
      size.width * 0.4059795,
      size.height * 0.9057901,
      size.width * 0.4097308,
      size.height * 0.9052222,
    );
    path_0.cubicTo(
      size.width * 0.4190872,
      size.height * 0.9037099,
      size.width * 0.4284410,
      size.height * 0.8988889,
      size.width * 0.4371410,
      size.height * 0.8956049,
    );
    path_0.cubicTo(
      size.width * 0.4383769,
      size.height * 0.8905432,
      size.width * 0.4391795,
      size.height * 0.8839753,
      size.width * 0.4402462,
      size.height * 0.8835494,
    );
    path_0.cubicTo(
      size.width * 0.4435282,
      size.height * 0.8818519,
      size.width * 0.4468667,
      size.height * 0.8815741,
      size.width * 0.4501718,
      size.height * 0.8827099,
    );
    path_0.cubicTo(
      size.width * 0.4537923,
      size.height * 0.8840062,
      size.width * 0.4573282,
      size.height * 0.8896667,
      size.width * 0.4609026,
      size.height * 0.8896667,
    );
    path_0.cubicTo(
      size.width * 0.4656462,
      size.height * 0.8896667,
      size.width * 0.4704077,
      size.height * 0.8864136,
      size.width * 0.4751128,
      size.height * 0.8836420,
    );
    path_0.cubicTo(
      size.width * 0.4767590,
      size.height * 0.8827099,
      size.width * 0.4782846,
      size.height * 0.8792407,
      size.width * 0.4806308,
      size.height * 0.8758086,
    );
    path_0.lineTo(size.width * 0.4959641, size.height * 0.8852099);
    path_0.lineTo(size.width * 0.4928692, size.height * 0.8926852);
    path_0.lineTo(size.width * 0.4969744, size.height * 0.8977160);
    path_0.lineTo(size.width * 0.4987615, size.height * 0.8764691);
    path_0.cubicTo(
      size.width * 0.5045436,
      size.height * 0.8829506,
      size.width * 0.5104077,
      size.height * 0.8927716,
      size.width * 0.5165359,
      size.height * 0.8953642,
    );
    path_0.cubicTo(
      size.width * 0.5224205,
      size.height * 0.8978951,
      size.width * 0.5285744,
      size.height * 0.8929259,
      size.width * 0.5346385,
      size.height * 0.8912654,
    );
    path_0.lineTo(size.width * 0.5346385, size.height * 0.8986481);
    path_0.lineTo(size.width * 0.5374436, size.height * 0.8920494);
    path_0.lineTo(size.width * 0.5388846, size.height * 0.9029877);
    path_0.cubicTo(
      size.width * 0.5391462,
      size.height * 0.8964815,
      size.width * 0.5392769,
      size.height * 0.8933765,
      size.width * 0.5393897,
      size.height * 0.8906914,
    );
    path_0.cubicTo(
      size.width * 0.5403846,
      size.height * 0.8917222,
      size.width * 0.5413462,
      size.height * 0.8930556,
      size.width * 0.5422615,
      size.height * 0.8946728,
    );
    path_0.cubicTo(
      size.width * 0.5428949,
      size.height * 0.8965185,
      size.width * 0.5434564,
      size.height * 0.8986111,
      size.width * 0.5439256,
      size.height * 0.9009074,
    );
    path_0.cubicTo(
      size.width * 0.5472487,
      size.height * 0.8964506,
      size.width * 0.5510359,
      size.height * 0.8972346,
      size.width * 0.5532077,
      size.height * 0.9089877,
    );
    path_0.cubicTo(
      size.width * 0.5561256,
      size.height * 0.9247778,
      size.width * 0.5577077,
      size.height * 0.9251420,
      size.width * 0.5625615,
      size.height * 0.9197778,
    );
    path_0.cubicTo(
      size.width * 0.5657897,
      size.height * 0.9161605,
      size.width * 0.5694000,
      size.height * 0.9128765,
      size.width * 0.5726564,
      size.height * 0.9142901,
    );
    path_0.cubicTo(
      size.width * 0.5765846,
      size.height * 0.9159815,
      size.width * 0.5789897,
      size.height * 0.9138086,
      size.width * 0.5803462,
      size.height * 0.9008519,
    );
    path_0.cubicTo(
      size.width * 0.5808077,
      size.height * 0.8978148,
      size.width * 0.5813872,
      size.height * 0.8949938,
      size.width * 0.5820769,
      size.height * 0.8924444,
    );
    path_0.lineTo(size.width * 0.5861256, size.height * 0.9011481);
    path_0.lineTo(size.width * 0.5827949, size.height * 0.9087469);
    path_0.cubicTo(
      size.width * 0.5878103,
      size.height * 0.9163086,
      size.width * 0.5865385,
      size.height * 0.8966914,
      size.width * 0.5889333,
      size.height * 0.8953642,
    );
    path_0.lineTo(size.width * 0.5962026, size.height * 0.8927716);
    path_0.cubicTo(
      size.width * 0.5964051,
      size.height * 0.8962469,
      size.width * 0.5968333,
      size.height * 0.8995432,
      size.width * 0.5974590,
      size.height * 0.9024444,
    );
    path_0.cubicTo(
      size.width * 0.5980846,
      size.height * 0.9053457,
      size.width * 0.5988949,
      size.height * 0.9077901,
      size.width * 0.5998359,
      size.height * 0.9096111,
    );
    path_0.cubicTo(
      size.width * 0.6007744,
      size.height * 0.9114321,
      size.width * 0.6018256,
      size.height * 0.9125926,
      size.width * 0.6029128,
      size.height * 0.9130185,
    );
    path_0.cubicTo(
      size.width * 0.6040026,
      size.height * 0.9134383,
      size.width * 0.6051077,
      size.height * 0.9131111,
      size.width * 0.6061538,
      size.height * 0.9120617,
    );
    path_0.cubicTo(
      size.width * 0.6125821,
      size.height * 0.9060309,
      size.width * 0.6195231,
      size.height * 0.9001852,
      size.width * 0.6245282,
      size.height * 0.8822840,
    );
    path_0.cubicTo(
      size.width * 0.6256513,
      size.height * 0.8783086,
      size.width * 0.6282692,
      size.height * 0.8743272,
      size.width * 0.6280923,
      size.height * 0.8717963,
    );
    path_0.cubicTo(
      size.width * 0.6272590,
      size.height * 0.8577840,
      size.width * 0.6301128,
      size.height * 0.8642346,
      size.width * 0.6316103,
      size.height * 0.8633580,
    );
    path_0.cubicTo(
      size.width * 0.6316949,
      size.height * 0.8611914,
      size.width * 0.6317769,
      size.height * 0.8590802,
      size.width * 0.6319282,
      size.height * 0.8553148,
    );
    path_0.cubicTo(
      size.width * 0.6354744,
      size.height * 0.8745679,
      size.width * 0.6339026,
      size.height * 0.8861111,
      size.width * 0.6279897,
      size.height * 0.8927407,
    );
    path_0.cubicTo(
      size.width * 0.6251821,
      size.height * 0.8959383,
      size.width * 0.6226000,
      size.height * 0.9025062,
      size.width * 0.6207949,
      size.height * 0.9058827,
    );
    path_0.cubicTo(
      size.width * 0.6214795,
      size.height * 0.9136605,
      size.width * 0.6223769,
      size.height * 0.9187222,
      size.width * 0.6221615,
      size.height * 0.9231481,
    );
    path_0.cubicTo(
      size.width * 0.6220128,
      size.height * 0.9261667,
      size.width * 0.6203462,
      size.height * 0.9285432,
      size.width * 0.6194026,
      size.height * 0.9310741,
    );
    path_0.cubicTo(
      size.width * 0.6222077,
      size.height * 0.9387346,
      size.width * 0.6226667,
      size.height * 0.9376173,
      size.width * 0.6246308,
      size.height * 0.9173642,
    );
    path_0.lineTo(size.width * 0.6286718, size.height * 0.9194136);
    path_0.lineTo(size.width * 0.6283077, size.height * 0.9159815);
    path_0.lineTo(size.width * 0.6368769, size.height * 0.9045864);
    path_0.cubicTo(
      size.width * 0.6369897,
      size.height * 0.9018765,
      size.width * 0.6371487,
      size.height * 0.8981975,
      size.width * 0.6371564,
      size.height * 0.8978642,
    );
    path_0.cubicTo(
      size.width * 0.6391026,
      size.height * 0.8930432,
      size.width * 0.6407308,
      size.height * 0.8906049,
      size.width * 0.6416385,
      size.height * 0.8863519,
    );
    path_0.cubicTo(
      size.width * 0.6430051,
      size.height * 0.8790926,
      size.width * 0.6442256,
      size.height * 0.8715556,
      size.width * 0.6452872,
      size.height * 0.8637840,
    );
    path_0.lineTo(size.width * 0.6437897, size.height * 0.8584198);
    path_0.lineTo(size.width * 0.6505077, size.height * 0.8614321);
    path_0.lineTo(size.width * 0.6511154, size.height * 0.8666173);
    path_0.cubicTo(
      size.width * 0.6534821,
      size.height * 0.8687531,
      size.width * 0.6552769,
      size.height * 0.8686358,
      size.width * 0.6560538,
      size.height * 0.8716173,
    );
    path_0.cubicTo(
      size.width * 0.6568308,
      size.height * 0.8745988,
      size.width * 0.6564564,
      size.height * 0.8804444,
      size.width * 0.6566154,
      size.height * 0.8855988,
    );
    path_0.cubicTo(
      size.width * 0.6622282,
      size.height * 0.8781852,
      size.width * 0.6564000,
      size.height * 0.8702593,
      size.width * 0.6564564,
      size.height * 0.8630000,
    );
    path_0.lineTo(size.width * 0.6596077, size.height * 0.8551049);
    path_0.cubicTo(
      size.width * 0.6603487,
      size.height * 0.8590185,
      size.width * 0.6610308,
      size.height * 0.8626049,
      size.width * 0.6616000,
      size.height * 0.8655617,
    );
    path_0.cubicTo(
      size.width * 0.6633974,
      size.height * 0.8638395,
      size.width * 0.6645846,
      size.height * 0.8625432,
      size.width * 0.6658026,
      size.height * 0.8615802,
    );
    path_0.cubicTo(
      size.width * 0.6670179,
      size.height * 0.8606173,
      size.width * 0.6684205,
      size.height * 0.8601667,
      size.width * 0.6699179,
      size.height * 0.8593827,
    );
    path_0.lineTo(size.width * 0.6684205, size.height * 0.8661296);
    path_0.cubicTo(
      size.width * 0.6692641,
      size.height * 0.8732469,
      size.width * 0.6699462,
      size.height * 0.8790617,
      size.width * 0.6707513,
      size.height * 0.8859630,
    );
    path_0.lineTo(size.width * 0.6655667, size.height * 0.8886420);
    path_0.cubicTo(
      size.width * 0.6676077,
      size.height * 0.8911728,
      size.width * 0.6693103,
      size.height * 0.8943395,
      size.width * 0.6695154,
      size.height * 0.8934074,
    );
    path_0.cubicTo(
      size.width * 0.6707308,
      size.height * 0.8879383,
      size.width * 0.6718333,
      size.height * 0.8822099,
      size.width * 0.6728077,
      size.height * 0.8762593,
    );
    path_0.cubicTo(
      size.width * 0.6753897,
      size.height * 0.8783395,
      size.width * 0.6779897,
      size.height * 0.8808704,
      size.width * 0.6806487,
      size.height * 0.8822840,
    );
    path_0.cubicTo(
      size.width * 0.6812359,
      size.height * 0.8825556,
      size.width * 0.6825179,
      size.height * 0.8786667,
      size.width * 0.6826128,
      size.height * 0.8764383,
    );
    path_0.cubicTo(
      size.width * 0.6829590,
      size.height * 0.8613704,
      size.width * 0.6872051,
      size.height * 0.8556728,
      size.width * 0.6894590,
      size.height * 0.8456667,
    );
    path_0.cubicTo(
      size.width * 0.6910513,
      size.height * 0.8386481,
      size.width * 0.6953641,
      size.height * 0.8383765,
      size.width * 0.6985154,
      size.height * 0.8360247,
    );
    path_0.cubicTo(
      size.width * 0.7024538,
      size.height * 0.8330123,
      size.width * 0.7064564,
      size.height * 0.8311728,
      size.width * 0.7106026,
      size.height * 0.8287037,
    );
    path_0.lineTo(size.width * 0.7174692, size.height * 0.8437716);
    path_0.lineTo(size.width * 0.7132205, size.height * 0.8423272);
    path_0.lineTo(size.width * 0.7130718, size.height * 0.8453395);
    path_0.lineTo(size.width * 0.7168128, size.height * 0.8488951);
    path_0.cubicTo(
      size.width * 0.7136692,
      size.height * 0.8617037,
      size.width * 0.7108359,
      size.height * 0.8733333,
      size.width * 0.7076923,
      size.height * 0.8861728,
    );
    path_0.cubicTo(
      size.width * 0.7122769,
      size.height * 0.8895185,
      size.width * 0.7129872,
      size.height * 0.8982284,
      size.width * 0.7110590,
      size.height * 0.9118827,
    );
    path_0.cubicTo(
      size.width * 0.7154385,
      size.height * 0.9054938,
      size.width * 0.7130256,
      size.height * 0.8956358,
      size.width * 0.7133513,
      size.height * 0.8874383,
    );
    path_0.cubicTo(
      size.width * 0.7196949,
      size.height * 0.8944630,
      size.width * 0.7187026,
      size.height * 0.8645062,
      size.width * 0.7232590,
      size.height * 0.8653765,
    );
    path_0.cubicTo(
      size.width * 0.7223974,
      size.height * 0.8578457,
      size.width * 0.7216308,
      size.height * 0.8511543,
      size.width * 0.7209026,
      size.height * 0.8446728,
    );
    path_0.cubicTo(
      size.width * 0.7265154,
      size.height * 0.8382284,
      size.width * 0.7312487,
      size.height * 0.8170679,
      size.width * 0.7368692,
      size.height * 0.8401852,
    );
    path_0.cubicTo(
      size.width * 0.7426154,
      size.height * 0.8321358,
      size.width * 0.7426231,
      size.height * 0.8320494,
      size.width * 0.7487795,
      size.height * 0.8398210,
    );
    path_0.cubicTo(
      size.width * 0.7519410,
      size.height * 0.8438333,
      size.width * 0.7550564,
      size.height * 0.8482901,
      size.width * 0.7581897,
      size.height * 0.8525432,
    );
    path_0.lineTo(size.width * 0.7586385, size.height * 0.8497407);
    path_0.lineTo(size.width * 0.7543077, size.height * 0.8391605);
    path_0.lineTo(size.width * 0.7577026, size.height * 0.8357531);
    path_0.cubicTo(
      size.width * 0.7587231,
      size.height * 0.8398827,
      size.width * 0.7595179,
      size.height * 0.8433765,
      size.width * 0.7595744,
      size.height * 0.8432593,
    );
    path_0.cubicTo(
      size.width * 0.7611179,
      size.height * 0.8396111,
      size.width * 0.7625872,
      size.height * 0.8356049,
      size.width * 0.7640923,
      size.height * 0.8315926,
    );
    path_0.lineTo(size.width * 0.7818667, size.height * 0.8581790);
    path_0.lineTo(size.width * 0.7790128, size.height * 0.8658333);
    path_0.cubicTo(
      size.width * 0.7809795,
      size.height * 0.8653210,
      size.width * 0.7825308,
      size.height * 0.8665247,
      size.width * 0.7830641,
      size.height * 0.8645370,
    );
    path_0.cubicTo(
      size.width * 0.7870590,
      size.height * 0.8496481,
      size.width * 0.7926538,
      size.height * 0.8497654,
      size.width * 0.7977128,
      size.height * 0.8469630,
    );
    path_0.cubicTo(
      size.width * 0.8059462,
      size.height * 0.8423827,
      size.width * 0.8124846,
      size.height * 0.8556173,
      size.width * 0.8173590,
      size.height * 0.8771049,
    );
    path_0.cubicTo(
      size.width * 0.8207462,
      size.height * 0.8921728,
      size.width * 0.8229718,
      size.height * 0.8956358,
      size.width * 0.8283795,
      size.height * 0.8885247,
    );
    path_0.lineTo(size.width * 0.8322615, size.height * 0.9000679);
    path_0.lineTo(size.width * 0.8429436, size.height * 0.8716790);
    path_0.cubicTo(
      size.width * 0.8437205,
      size.height * 0.8749321,
      size.width * 0.8448821,
      size.height * 0.8797222,
      size.width * 0.8465462,
      size.height * 0.8867469,
    );
    path_0.lineTo(size.width * 0.8539462, size.height * 0.8764074);
    path_0.lineTo(size.width * 0.8601846, size.height * 0.9022037);
    path_0.lineTo(size.width * 0.8593615, size.height * 0.9073580);
    path_0.lineTo(size.width * 0.8679590, size.height * 0.9022963);
    path_0.lineTo(size.width * 0.8745821, size.height * 0.9129630);
    path_0.lineTo(size.width * 0.8773897, size.height * 0.9041358);
    path_0.lineTo(size.width * 0.8811308, size.height * 0.9115802);
    path_0.cubicTo(
      size.width * 0.8843410,
      size.height * 0.8904815,
      size.width * 0.8899615,
      size.height * 0.8832222,
      size.width * 0.8968000,
      size.height * 0.8836420,
    );
    path_0.cubicTo(
      size.width * 0.8966333,
      size.height * 0.8822222,
      size.width * 0.8964718,
      size.height * 0.8807778,
      size.width * 0.8963128,
      size.height * 0.8793642,
    );
    path_0.lineTo(size.width * 0.8915051, size.height * 0.8793642);
    path_0.cubicTo(
      size.width * 0.8915051,
      size.height * 0.8781852,
      size.width * 0.8914205,
      size.height * 0.8770123,
      size.width * 0.8913744,
      size.height * 0.8758333,
    );
    path_0.cubicTo(
      size.width * 0.8932103,
      size.height * 0.8752037,
      size.width * 0.8950256,
      size.height * 0.8740741,
      size.width * 0.8968000,
      size.height * 0.8724630,
    );
    path_0.cubicTo(
      size.width * 0.8981923,
      size.height * 0.8702840,
      size.width * 0.8995051,
      size.height * 0.8676049,
      size.width * 0.9007103,
      size.height * 0.8644753,
    );
    path_0.lineTo(size.width * 0.8999256, size.height * 0.8603765);
    path_0.lineTo(size.width * 0.8950974, size.height * 0.8655926);
    path_0.cubicTo(
      size.width * 0.8948077,
      size.height * 0.8603457,
      size.width * 0.8945923,
      size.height * 0.8565494,
      size.width * 0.8944897,
      size.height * 0.8547716,
    );
    path_0.cubicTo(
      size.width * 0.8924872,
      size.height * 0.8534444,
      size.width * 0.8903179,
      size.height * 0.8538333,
      size.width * 0.8899718,
      size.height * 0.8513333,
    );
    path_0.cubicTo(
      size.width * 0.8894744,
      size.height * 0.8477160,
      size.width * 0.8903077,
      size.height * 0.8419630,
      size.width * 0.8907205,
      size.height * 0.8344259,
    );
    path_0.cubicTo(
      size.width * 0.8899154,
      size.height * 0.8314136,
      size.width * 0.8886513,
      size.height * 0.8266235,
      size.width * 0.8873897,
      size.height * 0.8218025,
    );
    path_0.lineTo(size.width * 0.8866795, size.height * 0.8236975);
    path_0.cubicTo(
      size.width * 0.8862667,
      size.height * 0.8192407,
      size.width * 0.8858641,
      size.height * 0.8146605,
      size.width * 0.8854051,
      size.height * 0.8098086,
    );
    path_0.lineTo(size.width * 0.8882128, size.height * 0.8041111);
    path_0.lineTo(size.width * 0.8912256, size.height * 0.8180926);
    path_0.cubicTo(
      size.width * 0.8981000,
      size.height * 0.7980247,
      size.width * 0.8992333,
      size.height * 0.7973272,
      size.width * 0.9056692,
      size.height * 0.8129136,
    );
    path_0.cubicTo(
      size.width * 0.9068282,
      size.height * 0.8157160,
      size.width * 0.9071179,
      size.height * 0.8227037,
      size.width * 0.9080462,
      size.height * 0.8295185,
    );
    path_0.cubicTo(
      size.width * 0.9116744,
      size.height * 0.8284938,
      size.width * 0.9086051,
      size.height * 0.8174630,
      size.width * 0.9089795,
      size.height * 0.8106481,
    );
    path_0.lineTo(size.width * 0.9163231, size.height * 0.8106481);
    path_0.cubicTo(
      size.width * 0.9159487,
      size.height * 0.8183025,
      size.width * 0.9156231,
      size.height * 0.8248457,
      size.width * 0.9152487,
      size.height * 0.8325309,
    );
    path_0.lineTo(size.width * 0.9123487, size.height * 0.8360864);
    path_0.lineTo(size.width * 0.9179615, size.height * 0.8400062);
    path_0.lineTo(size.width * 0.9145923, size.height * 0.8470556);
    path_0.cubicTo(
      size.width * 0.9191308,
      size.height * 0.8525432,
      size.width * 0.9214410,
      size.height * 0.8485000,
      size.width * 0.9225359,
      size.height * 0.8340370,
    );
    path_0.lineTo(size.width * 0.9298615, size.height * 0.8287654);
    path_0.cubicTo(
      size.width * 0.9298615,
      size.height * 0.8273148,
      size.width * 0.9299718,
      size.height * 0.8242099,
      size.width * 0.9300205,
      size.height * 0.8218642,
    );
    path_0.cubicTo(
      size.width * 0.9330128,
      size.height * 0.8181235,
      size.width * 0.9362692,
      size.height * 0.8151420,
      size.width * 0.9371949,
      size.height * 0.8277407,
    );
    path_0.cubicTo(
      size.width * 0.9381308,
      size.height * 0.8409074,
      size.width * 0.9411692,
      size.height * 0.8417531,
      size.width * 0.9438179,
      size.height * 0.8461790,
    );
    path_0.cubicTo(
      size.width * 0.9441410,
      size.height * 0.8452160,
      size.width * 0.9444923,
      size.height * 0.8443457,
      size.width * 0.9448667,
      size.height * 0.8435926,
    );
    path_0.cubicTo(
      size.width * 0.9473923,
      size.height * 0.8394938,
      size.width * 0.9509000,
      size.height * 0.8299383,
      size.width * 0.9522641,
      size.height * 0.8326790,
    );
    path_0.cubicTo(
      size.width * 0.9548282,
      size.height * 0.8378025,
      size.width * 0.9588128,
      size.height * 0.8447346,
      size.width * 0.9575128,
      size.height * 0.8605247,
    );
    path_0.cubicTo(
      size.width * 0.9573744,
      size.height * 0.8622469,
      size.width * 0.9580846,
      size.height * 0.8649259,
      size.width * 0.9584487,
      size.height * 0.8669444,
    );
    path_0.cubicTo(
      size.width * 0.9596359,
      size.height * 0.8729753,
      size.width * 0.9607692,
      size.height * 0.8793025,
      size.width * 0.9621077,
      size.height * 0.8850309,
    );
    path_0.cubicTo(
      size.width * 0.9633256,
      size.height * 0.8896975,
      size.width * 0.9646179,
      size.height * 0.8941667,
      size.width * 0.9659795,
      size.height * 0.8984074,
    );
    path_0.cubicTo(
      size.width * 0.9661667,
      size.height * 0.8953951,
      size.width * 0.9663154,
      size.height * 0.8927099,
      size.width * 0.9665231,
      size.height * 0.8893704,
    );
    path_0.cubicTo(
      size.width * 0.9745949,
      size.height * 0.9007284,
      size.width * 0.9802179,
      size.height * 0.8705617,
      size.width * 0.9881872,
      size.height * 0.8758642,
    );
    path_0.cubicTo(
      size.width * 0.9877949,
      size.height * 0.8724012,
      size.width * 0.9875231,
      size.height * 0.8698395,
      size.width * 0.9867564,
      size.height * 0.8632099,
    );
    path_0.cubicTo(
      size.width * 0.9893282,
      size.height * 0.8671852,
      size.width * 0.9907692,
      size.height * 0.8697778,
      size.width * 0.9922949,
      size.height * 0.8717099,
    );
    path_0.cubicTo(
      size.width * 0.9953923,
      size.height * 0.8756235,
      size.width * 0.9984974,
      size.height * 0.8731543,
      size.width * 1.000574,
      size.height * 0.8897901,
    );
    path_0.cubicTo(
      size.width * 1.002500,
      size.height * 0.9052778,
      size.width * 1.008992,
      size.height * 0.9142284,
      size.width * 1.015167,
      size.height * 0.9070556,
    );
    path_0.cubicTo(
      size.width * 1.016103,
      size.height * 0.9059136,
      size.width * 1.016887,
      size.height * 0.9023272,
      size.width * 1.017974,
      size.height * 0.8993148,
    );
    path_0.cubicTo(
      size.width * 1.022315,
      size.height * 0.9031111,
      size.width * 1.026982,
      size.height * 0.8904815,
      size.width * 1.026767,
      size.height * 0.8719815,
    );
    path_0.cubicTo(
      size.width * 1.028254,
      size.height * 0.8748086,
      size.width * 1.029500,
      size.height * 0.8773148,
      size.width * 1.030779,
      size.height * 0.8795741,
    );
    path_0.cubicTo(
      size.width * 1.031818,
      size.height * 0.8813827,
      size.width * 1.032959,
      size.height * 0.8846049,
      size.width * 1.033962,
      size.height * 0.8842469,
    );
    path_0.cubicTo(
      size.width * 1.039228,
      size.height * 0.8821975,
      size.width * 1.044477,
      size.height * 0.8792407,
      size.width * 1.049723,
      size.height * 0.8764691,
    );
    path_0.cubicTo(
      size.width * 1.050379,
      size.height * 0.8761049,
      size.width * 1.051538,
      size.height * 0.8750247,
      size.width * 1.051595,
      size.height * 0.8740556,
    );
    path_0.cubicTo(
      size.width * 1.051849,
      size.height * 0.8616728,
      size.width * 1.054933,
      size.height * 0.8654383,
      size.width * 1.056741,
      size.height * 0.8645370,
    );
    path_0.cubicTo(
      size.width * 1.058949,
      size.height * 0.8634506,
      size.width * 1.061305,
      size.height * 0.8658333,
      size.width * 1.063474,
      size.height * 0.8666728,
    );
    path_0.cubicTo(
      size.width * 1.063690,
      size.height * 0.8607963,
      size.width * 1.063887,
      size.height * 0.8555247,
      size.width * 1.064113,
      size.height * 0.8495556,
    );
    path_0.cubicTo(
      size.width * 1.069182,
      size.height * 0.8503704,
      size.width * 1.067572,
      size.height * 0.8668272,
      size.width * 1.068864,
      size.height * 0.8714383,
    );
    path_0.lineTo(size.width * 1.075833, size.height * 0.8740000);
    path_0.cubicTo(
      size.width * 1.076441,
      size.height * 0.8685741,
      size.width * 1.077200,
      size.height * 0.8617346,
      size.width * 1.078210,
      size.height * 0.8526296,
    );
    path_0.lineTo(size.width * 1.089295, size.height * 0.8526296);
    path_0.cubicTo(
      size.width * 1.092156,
      size.height * 0.8452160,
      size.width * 1.099659,
      size.height * 0.8475988,
      size.width * 1.103682,
      size.height * 0.8580556,
    );
    path_0.lineTo(size.width * 1.144695, size.height * 0.8509753);
    path_0.lineTo(size.width * 1.141131, size.height * 0.8475062);
    path_0.cubicTo(
      size.width * 1.145105,
      size.height * 0.8404568,
      size.width * 1.148482,
      size.height * 0.8463025,
      size.width * 1.151972,
      size.height * 0.8512469,
    );
    path_0.cubicTo(
      size.width * 1.155715,
      size.height * 0.8565494,
      size.width * 1.159597,
      size.height * 0.8609815,
      size.width * 1.163564,
      size.height * 0.8659815,
    );
    path_0.cubicTo(
      size.width * 1.164069,
      size.height * 0.8593519,
      size.width * 1.164367,
      size.height * 0.8554938,
      size.width * 1.164667,
      size.height * 0.8516358,
    );
    path_0.lineTo(size.width * 1.163656, size.height * 0.8541049);
    path_0.lineTo(size.width * 1.155313, size.height * 0.8257469);
    path_0.cubicTo(
      size.width * 1.163731,
      size.height * 0.8162531,
      size.width * 1.172282,
      size.height * 0.8160432,
      size.width * 1.181346,
      size.height * 0.8164074,
    );
    path_0.cubicTo(
      size.width * 1.180195,
      size.height * 0.8087840,
      size.width * 1.179597,
      size.height * 0.8047407,
      size.width * 1.178951,
      size.height * 0.8004938,
    );
    path_0.lineTo(size.width * 1.182085, size.height * 0.7981728);
    path_0.lineTo(size.width * 1.178700, size.height * 0.7873827);
    path_0.lineTo(size.width * 1.184313, size.height * 0.7665309);
    path_0.cubicTo(
      size.width * 1.183795,
      size.height * 0.7660988,
      size.width * 1.183249,
      size.height * 0.7661543,
      size.width * 1.182738,
      size.height * 0.7666852,
    );
    path_0.cubicTo(
      size.width * 1.182231,
      size.height * 0.7672222,
      size.width * 1.181779,
      size.height * 0.7682099,
      size.width * 1.181441,
      size.height * 0.7695432,
    );
    path_0.cubicTo(
      size.width * 1.180964,
      size.height * 0.7723951,
      size.width * 1.180608,
      size.height * 0.7754383,
      size.width * 1.180374,
      size.height * 0.7785864,
    );
    path_0.lineTo(size.width * 1.176885, size.height * 0.7732531);
    path_0.lineTo(size.width * 1.179474, size.height * 0.7715000);
    path_0.cubicTo(
      size.width * 1.173246,
      size.height * 0.7699938,
      size.width * 1.173246,
      size.height * 0.7699630,
      size.width * 1.173862,
      size.height * 0.7555617,
    );
    path_0.cubicTo(
      size.width * 1.177390,
      size.height * 0.7530000,
      size.width * 1.182226,
      size.height * 0.7591790,
      size.width * 1.184097,
      size.height * 0.7401296,
    );
    path_0.lineTo(size.width * 1.192890, size.height * 0.7304877);
    path_0.cubicTo(
      size.width * 1.185641,
      size.height * 0.7254506,
      size.width * 1.189103,
      size.height * 0.7097840,
      size.width * 1.189149,
      size.height * 0.6985432,
    );
    path_0.lineTo(size.width * 1.167633, size.height * 0.6850679);
    path_0.cubicTo(
      size.width * 1.169662,
      size.height * 0.6809444,
      size.width * 1.171272,
      size.height * 0.6760309,
      size.width * 1.173144,
      size.height * 0.6741296,
    );
    path_0.cubicTo(
      size.width * 1.176415,
      size.height * 0.6706358,
      size.width * 1.179849,
      size.height * 0.6688580,
      size.width * 1.183218,
      size.height * 0.6663272,
    );
    path_0.cubicTo(
      size.width * 1.182526,
      size.height * 0.6538457,
      size.width * 1.181495,
      size.height * 0.6512593,
      size.width * 1.178838,
      size.height * 0.6495062,
    );
    path_0.cubicTo(
      size.width * 1.174910,
      size.height * 0.6468580,
      size.width * 1.171103,
      size.height * 0.6423086,
      size.width * 1.167238,
      size.height * 0.6385679,
    );
    path_0.cubicTo(
      size.width * 1.167238,
      size.height * 0.6376358,
      size.width * 1.167315,
      size.height * 0.6367037,
      size.width * 1.167362,
      size.height * 0.6357654,
    );
    path_0.lineTo(size.width * 1.174844, size.height * 0.6277469);
    path_0.lineTo(size.width * 1.173067, size.height * 0.6121389);
    path_0.lineTo(size.width * 1.165267, size.height * 0.6030981);
    path_0.lineTo(size.width * 1.169728, size.height * 0.5955037);
    path_0.lineTo(size.width * 1.162703, size.height * 0.5644623);
    path_0.lineTo(size.width * 1.163423, size.height * 0.5625944);
    path_0.lineTo(size.width * 1.156267, size.height * 0.5561753);
    path_0.cubicTo(
      size.width * 1.156387,
      size.height * 0.5546981,
      size.width * 1.156518,
      size.height * 0.5531611,
      size.width * 1.156641,
      size.height * 0.5517451,
    );
    path_0.lineTo(size.width * 1.158662, size.height * 0.5517451);
    path_0.lineTo(size.width * 1.153533, size.height * 0.5232056);
    path_0.lineTo(size.width * 1.175564, size.height * 0.4927975);
    path_0.cubicTo(
      size.width * 1.178372,
      size.height * 0.4971370,
      size.width * 1.179308,
      size.height * 0.4848710,
      size.width * 1.181862,
      size.height * 0.4790247,
    );
    path_0.lineTo(size.width * 1.175377, size.height * 0.4690191);
    path_0.lineTo(size.width * 1.186959, size.height * 0.4516302);
    path_0.lineTo(size.width * 1.186846, size.height * 0.4480142);
    path_0.lineTo(size.width * 1.180523, size.height * 0.4450000);
    path_0.cubicTo(
      size.width * 1.183872,
      size.height * 0.4301130,
      size.width * 1.190992,
      size.height * 0.4379481,
      size.width * 1.193854,
      size.height * 0.4208907,
    );
    path_0.lineTo(size.width * 1.180869, size.height * 0.4052500);
    path_0.lineTo(size.width * 1.198877, size.height * 0.3928938);
    path_0.cubicTo(
      size.width * 1.196772,
      size.height * 0.3826173,
      size.width * 1.197221,
      size.height * 0.3739377,
      size.width * 1.200000,
      size.height * 0.3687846,
    );
    path_0.lineTo(size.width * 1.185221, size.height * 0.3440117);
    path_0.lineTo(size.width * 1.189700, size.height * 0.3375321);
    path_0.cubicTo(
      size.width * 1.190300,
      size.height * 0.3309623,
      size.width * 1.190944,
      size.height * 0.3238802,
      size.width * 1.191328,
      size.height * 0.3194500,
    );
    path_0.lineTo(size.width * 1.189851, size.height * 0.3029654);
    path_0.lineTo(size.width * 1.171505, size.height * 0.2969383);
    path_0.cubicTo(
      size.width * 1.171505,
      size.height * 0.2956420,
      size.width * 1.171505,
      size.height * 0.2943160,
      size.width * 1.171505,
      size.height * 0.2930204,
    );
    path_0.lineTo(size.width * 1.178587, size.height * 0.2746370);
    path_0.cubicTo(
      size.width * 1.177838,
      size.height * 0.2659877,
      size.width * 1.176874,
      size.height * 0.2548673,
      size.width * 1.175892,
      size.height * 0.2434753,
    );
    path_0.lineTo(size.width * 1.169344, size.height * 0.2434753);
    path_0.lineTo(size.width * 1.174574, size.height * 0.2650235);
    path_0.cubicTo(
      size.width * 1.169633,
      size.height * 0.2710506,
      size.width * 1.165667,
      size.height * 0.2859080,
      size.width * 1.159044,
      size.height * 0.2803932,
    );
    path_0.lineTo(size.width * 1.162151, size.height * 0.2741846);
    path_0.cubicTo(
      size.width * 1.146369,
      size.height * 0.2769877,
      size.width * 1.131008,
      size.height * 0.2623407,
      size.width * 1.116779,
      size.height * 0.2828340,
    );
    path_0.lineTo(size.width * 1.108472, size.height * 0.2617383);
    path_0.lineTo(size.width * 1.108754, size.height * 0.2563741);
    path_0.lineTo(size.width * 1.115956, size.height * 0.2469710);
    path_0.lineTo(size.width * 1.112167, size.height * 0.2300043);
    path_0.lineTo(size.width * 1.112541, size.height * 0.2286784);
    path_0.lineTo(size.width * 1.114582, size.height * 0.2328370);
    path_0.lineTo(size.width * 1.115059, size.height * 0.2303957);
    path_0.lineTo(size.width * 1.111615, size.height * 0.2222593);
    path_0.lineTo(size.width * 1.119100, size.height * 0.2108068);
    path_0.lineTo(size.width * 1.118931, size.height * 0.2067988);
    path_0.lineTo(size.width * 1.113318, size.height * 0.2020975);
    path_0.lineTo(size.width * 1.117238, size.height * 0.1842864);
    path_0.cubicTo(
      size.width * 1.114123,
      size.height * 0.1790728,
      size.width * 1.101962,
      size.height * 0.1886864,
      size.width * 1.098351,
      size.height * 0.1967932,
    );
    path_0.lineTo(size.width * 1.101156, size.height * 0.1830815);
    path_0.lineTo(size.width * 1.110623, size.height * 0.1760290);
    path_0.cubicTo(
      size.width * 1.109238,
      size.height * 0.1707852,
      size.width * 1.108828,
      size.height * 0.1692784,
      size.width * 1.108069,
      size.height * 0.1663852,
    );
    path_0.lineTo(size.width * 1.112056, size.height * 0.1635827);
    path_0.cubicTo(
      size.width * 1.112403,
      size.height * 0.1587605,
      size.width * 1.112682,
      size.height * 0.1549333,
      size.width * 1.113233,
      size.height * 0.1473994,
    );
    path_0.lineTo(size.width * 1.105872, size.height * 0.1664457);
    path_0.lineTo(size.width * 1.101054, size.height * 0.1600870);
    path_0.lineTo(size.width * 1.099062, size.height * 0.1721414);
    path_0.cubicTo(
      size.width * 1.095833,
      size.height * 0.1673500,
      size.width * 1.098482,
      size.height * 0.1448679,
      size.width * 1.092579,
      size.height * 0.1478210,
    );
    path_0.lineTo(size.width * 1.092579, size.height * 0.1568623);
    path_0.lineTo(size.width * 1.081838, size.height * 0.1508346);
    path_0.cubicTo(
      size.width * 1.082887,
      size.height * 0.1405883,
      size.width * 1.085713,
      size.height * 0.1274790,
      size.width * 1.079108,
      size.height * 0.1284130,
    );
    path_0.cubicTo(
      size.width * 1.078931,
      size.height * 0.1284130,
      size.width * 1.078695,
      size.height * 0.1261228,
      size.width * 1.078528,
      size.height * 0.1248265,
    );
    path_0.cubicTo(
      size.width * 1.077526,
      size.height * 0.1168407,
      size.width * 1.076282,
      size.height * 0.1170210,
      size.width * 1.074364,
      size.height * 0.1221444,
    );
    path_0.cubicTo(
      size.width * 1.069864,
      size.height * 0.1341994,
      size.width * 1.068218,
      size.height * 0.1327228,
      size.width * 1.065946,
      size.height * 0.1172019,
    );
    path_0.lineTo(size.width * 1.061344, size.height * 0.1316074);
    path_0.lineTo(size.width * 1.050118, size.height * 0.1016815);
    path_0.cubicTo(
      size.width * 1.048836,
      size.height * 0.1072265,
      size.width * 1.048518,
      size.height * 0.1157556,
      size.width * 1.044728,
      size.height * 0.1093364,
    );
    path_0.cubicTo(
      size.width * 1.041492,
      size.height * 0.1038512,
      size.width * 1.036992,
      size.height * 0.1068654,
      size.width * 1.033054,
      size.height * 0.1063228,
    );
    path_0.cubicTo(
      size.width * 1.030836,
      size.height * 0.1060815,
      size.width * 1.028377,
      size.height * 0.1044846,
      size.width * 1.026505,
      size.height * 0.1070759,
    );
    path_0.cubicTo(
      size.width * 1.024633,
      size.height * 0.1096679,
      size.width * 1.023408,
      size.height * 0.1166599,
      size.width * 1.021772,
      size.height * 0.1221444,
    );
    path_0.lineTo(size.width * 1.019592, size.height * 0.09589506);
    path_0.lineTo(size.width * 1.022633, size.height * 0.08866235);
    path_0.cubicTo(
      size.width * 1.016000,
      size.height * 0.09227901,
      size.width * 1.009621,
      size.height * 0.09652840,
      size.width * 1.003344,
      size.height * 0.08471481,
    );
    path_0.lineTo(size.width * 1.006459, size.height * 0.08064630);
    path_0.cubicTo(
      size.width * 1.002903,
      size.height * 0.07883765,
      size.width * 1.000451,
      size.height * 0.06835062,
      size.width * 0.9977308,
      size.height * 0.07992284,
    );
    path_0.cubicTo(
      size.width * 0.9944923,
      size.height * 0.06184074,
      size.width * 0.9854385,
      size.height * 0.06274506,
      size.width * 0.9734077,
      size.height * 0.08251481,
    );
    path_0.cubicTo(
      size.width * 0.9735846,
      size.height * 0.07678889,
      size.width * 0.9737718,
      size.height * 0.07091173,
      size.width * 0.9740051,
      size.height * 0.06367901,
    );
    path_0.cubicTo(
      size.width * 0.9710410,
      size.height * 0.05735037,
      size.width * 0.9679436,
      size.height * 0.05072025,
      size.width * 0.9647641,
      size.height * 0.04396963,
    );
    path_0.lineTo(size.width * 0.9620590, size.height * 0.05044901);
    path_0.cubicTo(
      size.width * 0.9620026,
      size.height * 0.03869568,
      size.width * 0.9604513,
      size.height * 0.03504914,
      size.width * 0.9572513,
      size.height * 0.03709846,
    );
    path_0.cubicTo(
      size.width * 0.9550538,
      size.height * 0.03845457,
      size.width * 0.9527333,
      size.height * 0.03733951,
      size.width * 0.9501333,
      size.height * 0.03733951,
    );
    path_0.cubicTo(
      size.width * 0.9501333,
      size.height * 0.03733951,
      size.width * 0.9498231,
      size.height * 0.03495870,
      size.width * 0.9494590,
      size.height * 0.03221623,
    );
    path_0.lineTo(size.width * 0.9402256, size.height * 0.06184074);
    path_0.cubicTo(
      size.width * 0.9406385,
      size.height * 0.07425741,
      size.width * 0.9359128,
      size.height * 0.08486543,
      size.width * 0.9291692,
      size.height * 0.08293642,
    );
    path_0.cubicTo(
      size.width * 0.9289333,
      size.height * 0.08634198,
      size.width * 0.9287103,
      size.height * 0.08980802,
      size.width * 0.9285872,
      size.height * 0.09149568,
    );
    path_0.lineTo(size.width * 0.9238256, size.height * 0.08899383);
    path_0.lineTo(size.width * 0.9255667, size.height * 0.07995309);
    path_0.cubicTo(
      size.width * 0.9220487,
      size.height * 0.07754198,
      size.width * 0.9181564,
      size.height * 0.07766235,
      size.width * 0.9152103,
      size.height * 0.07208704,
    );
    path_0.cubicTo(
      size.width * 0.9120026,
      size.height * 0.06605988,
      size.width * 0.9089333,
      size.height * 0.06033389,
      size.width * 0.9053051,
      size.height * 0.05921883,
    );
    path_0.cubicTo(
      size.width * 0.9029103,
      size.height * 0.05849556,
      size.width * 0.9004872,
      size.height * 0.05921883,
      size.width * 0.8980718,
      size.height * 0.05921883,
    );
    path_0.cubicTo(
      size.width * 0.8979333,
      size.height * 0.05638599,
      size.width * 0.8976897,
      size.height * 0.05156407,
      size.width * 0.8974462,
      size.height * 0.04677235,
    );
    path_0.lineTo(size.width * 0.8965103, size.height * 0.04677235);
    path_0.cubicTo(
      size.width * 0.8960051,
      size.height * 0.05298056,
      size.width * 0.8954897,
      size.height * 0.05915858,
      size.width * 0.8950051,
      size.height * 0.06515556,
    );
    path_0.lineTo(size.width * 0.8939846, size.height * 0.06367901);
    path_0.lineTo(size.width * 0.8868282, size.height * 0.09459938);
    path_0.cubicTo(
      size.width * 0.8867077,
      size.height * 0.1027667,
      size.width * 0.8865846,
      size.height * 0.1113858,
      size.width * 0.8864641,
      size.height * 0.1195525,
    );
    path_0.cubicTo(
      size.width * 0.8850974,
      size.height * 0.1207580,
      size.width * 0.8839179,
      size.height * 0.1206377,
      size.width * 0.8833103,
      size.height * 0.1225667,
    );
    path_0.cubicTo(
      size.width * 0.8827026,
      size.height * 0.1244951,
      size.width * 0.8827487,
      size.height * 0.1296488,
      size.width * 0.8820846,
      size.height * 0.1318488,
    );
    path_0.cubicTo(
      size.width * 0.8797385,
      size.height * 0.1396543,
      size.width * 0.8718513,
      size.height * 0.1286543,
      size.width * 0.8705128,
      size.height * 0.1151228,
    );
    path_0.lineTo(size.width * 0.8624128, size.height * 0.1265747);
    path_0.cubicTo(
      size.width * 0.8613538,
      size.height * 0.1494784,
      size.width * 0.8613538,
      size.height * 0.1494784,
      size.width * 0.8520744,
      size.height * 0.1476704,
    );
    path_0.lineTo(size.width * 0.8520744, size.height * 0.1341691);
    path_0.lineTo(size.width * 0.8515051, size.height * 0.1380870);
    path_0.lineTo(size.width * 0.8421487, size.height * 0.1318790);
    path_0.cubicTo(
      size.width * 0.8439462,
      size.height * 0.1128321,
      size.width * 0.8390897,
      size.height * 0.1146407,
      size.width * 0.8362462,
      size.height * 0.1112951,
    );
    path_0.cubicTo(
      size.width * 0.8351897,
      size.height * 0.1100599,
      size.width * 0.8335436,
      size.height * 0.1147006,
      size.width * 0.8320923,
      size.height * 0.1167500,
    );
    path_0.cubicTo(
      size.width * 0.8342077,
      size.height * 0.1194623,
      size.width * 0.8353667,
      size.height * 0.1209086,
      size.width * 0.8365077,
      size.height * 0.1225667,
    );
    path_0.cubicTo(
      size.width * 0.8366205,
      size.height * 0.1225667,
      size.width * 0.8365744,
      size.height * 0.1241938,
      size.width * 0.8366308,
      size.height * 0.1255802,
    );
    path_0.lineTo(size.width * 0.8341128, size.height * 0.1255802);
    path_0.lineTo(size.width * 0.8353487, size.height * 0.1328432);
    path_0.cubicTo(
      size.width * 0.8345897,
      size.height * 0.1388704,
      size.width * 0.8334026,
      size.height * 0.1433907,
      size.width * 0.8336846,
      size.height * 0.1465556,
    );
    path_0.cubicTo(
      size.width * 0.8346949,
      size.height * 0.1582481,
      size.width * 0.8362000,
      size.height * 0.1694895,
      size.width * 0.8375949,
      size.height * 0.1815444,
    );
    path_0.cubicTo(
      size.width * 0.8346949,
      size.height * 0.1864864,
      size.width * 0.8321026,
      size.height * 0.1896512,
      size.width * 0.8298846,
      size.height * 0.1756975,
    );
    path_0.cubicTo(
      size.width * 0.8291641,
      size.height * 0.1711772,
      size.width * 0.8265641,
      size.height * 0.1701222,
      size.width * 0.8248513,
      size.height * 0.1675006,
    );
    path_0.cubicTo(
      size.width * 0.8254231,
      size.height * 0.1597253,
      size.width * 0.8261718,
      size.height * 0.1494185,
      size.width * 0.8270231,
      size.height * 0.1377858,
    );
    path_0.lineTo(size.width * 0.8220564, size.height * 0.1377858);
    path_0.cubicTo(
      size.width * 0.8229897,
      size.height * 0.1413716,
      size.width * 0.8244974,
      size.height * 0.1452593,
      size.width * 0.8243103,
      size.height * 0.1468265,
    );
    path_0.cubicTo(
      size.width * 0.8235718,
      size.height * 0.1524667,
      size.width * 0.8226641,
      size.height * 0.1578660,
      size.width * 0.8216051,
      size.height * 0.1629500,
    );
    path_0.lineTo(size.width * 0.8176026, size.height * 0.1629500);
    path_0.lineTo(size.width * 0.8213436, size.height * 0.1941716);
    path_0.cubicTo(
      size.width * 0.8123462,
      size.height * 0.1919414,
      size.width * 0.8095487,
      size.height * 0.1637938,
      size.width * 0.8035231,
      size.height * 0.1523716,
    );
    path_0.cubicTo(
      size.width * 0.8021667,
      size.height * 0.1599062,
      size.width * 0.8010436,
      size.height * 0.1660537,
      size.width * 0.7998462,
      size.height * 0.1726537,
    );
    path_0.lineTo(size.width * 0.7962744, size.height * 0.1630401);
    path_0.cubicTo(
      size.width * 0.7969564,
      size.height * 0.1561086,
      size.width * 0.7976103,
      size.height * 0.1495086,
      size.width * 0.7979769,
      size.height * 0.1457117,
    );
    path_0.cubicTo(
      size.width * 0.7996308,
      size.height * 0.1438432,
      size.width * 0.8014744,
      size.height * 0.1433006,
      size.width * 0.8016051,
      size.height * 0.1413420,
    );
    path_0.cubicTo(
      size.width * 0.8019949,
      size.height * 0.1340870,
      size.width * 0.8021846,
      size.height * 0.1267346,
      size.width * 0.8021667,
      size.height * 0.1193722,
    );
    path_0.cubicTo(
      size.width * 0.8022333,
      size.height * 0.1146704,
      size.width * 0.8021667,
      size.height * 0.1099691,
      size.width * 0.8021667,
      size.height * 0.1055389,
    );
    path_0.lineTo(size.width * 0.8082000, size.height * 0.1071062);
    path_0.lineTo(size.width * 0.8082000, size.height * 0.09074198);
    path_0.lineTo(size.width * 0.8145333, size.height * 0.09854753);
    path_0.cubicTo(
      size.width * 0.8156385,
      size.height * 0.08781852,
      size.width * 0.8140487,
      size.height * 0.08263519,
      size.width * 0.8104564,
      size.height * 0.08221296,
    );
    path_0.cubicTo(
      size.width * 0.8081641,
      size.height * 0.08191173,
      size.width * 0.8059077,
      size.height * 0.07892840,
      size.width * 0.8036462,
      size.height * 0.07718025,
    );
    path_0.lineTo(size.width * 0.8039821, size.height * 0.07238889);
    path_0.lineTo(size.width * 0.8103795, size.height * 0.07389568);
    path_0.cubicTo(
      size.width * 0.8103795,
      size.height * 0.07238889,
      size.width * 0.8104846,
      size.height * 0.07088210,
      size.width * 0.8105308,
      size.height * 0.06937469,
    );
    path_0.lineTo(size.width * 0.8009974, size.height * 0.06334753);
    path_0.lineTo(size.width * 0.7998282, size.height * 0.07049012);
    path_0.cubicTo(
      size.width * 0.7976769,
      size.height * 0.06144895,
      size.width * 0.7956103,
      size.height * 0.05204630,
      size.width * 0.7933359,
      size.height * 0.04336691,
    );
    path_0.cubicTo(
      size.width * 0.7918590,
      size.height * 0.03773130,
      size.width * 0.7903897,
      size.height * 0.02751494,
      size.width * 0.7877692,
      size.height * 0.04035321,
    );
    path_0.cubicTo(
      size.width * 0.7874897,
      size.height * 0.04176963,
      size.width * 0.7858513,
      size.height * 0.03993130,
      size.width * 0.7844949,
      size.height * 0.03950938,
    );
    path_0.lineTo(size.width * 0.7876667, size.height * 0.02368753);
    path_0.lineTo(size.width * 0.7749436, size.height * 0.04393951);
    path_0.cubicTo(
      size.width * 0.7725769,
      size.height * 0.04324636,
      size.width * 0.7707821,
      size.height * 0.04315593,
      size.width * 0.7690231,
      size.height * 0.04219154,
    );
    path_0.cubicTo(
      size.width * 0.7648026,
      size.height * 0.03990117,
      size.width * 0.7648128,
      size.height * 0.03975049,
      size.width * 0.7637000,
      size.height * 0.04481346,
    );
    path_0.lineTo(size.width * 0.7661513, size.height * 0.04559704);
    path_0.lineTo(size.width * 0.7574872, size.height * 0.06723519);
    path_0.lineTo(size.width * 0.7609692, size.height * 0.07079136);
    path_0.lineTo(size.width * 0.7552256, size.height * 0.08028457);
    path_0.cubicTo(
      size.width * 0.7534385,
      size.height * 0.06557778,
      size.width * 0.7496590,
      size.height * 0.06838025,
      size.width * 0.7478615,
      size.height * 0.06446296,
    );
    path_0.lineTo(size.width * 0.7416410, size.height * 0.09267099);
    path_0.lineTo(size.width * 0.7388897, size.height * 0.08769815);
    path_0.lineTo(size.width * 0.7408359, size.height * 0.07672840);
    path_0.lineTo(size.width * 0.7295179, size.height * 0.04743537);
    path_0.lineTo(size.width * 0.7234923, size.height * 0.06901358);
    path_0.cubicTo(
      size.width * 0.7228846,
      size.height * 0.06298580,
      size.width * 0.7224538,
      size.height * 0.05855586,
      size.width * 0.7219872,
      size.height * 0.05376407,
    );
    path_0.cubicTo(
      size.width * 0.7197795,
      size.height * 0.06214198,
      size.width * 0.7181128,
      size.height * 0.06813951,
      size.width * 0.7162154,
      size.height * 0.05515037,
    );
    path_0.lineTo(size.width * 0.7106769, size.height * 0.08411173);
    path_0.cubicTo(
      size.width * 0.7055513,
      size.height * 0.08739691,
      size.width * 0.7030513,
      size.height * 0.1056901,
      size.width * 0.6997308,
      size.height * 0.1211198,
    );
    path_0.cubicTo(
      size.width * 0.6992538,
      size.height * 0.1172321,
      size.width * 0.6987949,
      size.height * 0.1133444,
      size.width * 0.6982436,
      size.height * 0.1088543,
    );
    path_0.cubicTo(
      size.width * 0.6968974,
      size.height * 0.1118679,
      size.width * 0.6959333,
      size.height * 0.1158759,
      size.width * 0.6949333,
      size.height * 0.1160265,
    );
    path_0.cubicTo(
      size.width * 0.6912923,
      size.height * 0.1168426,
      size.width * 0.6876359,
      size.height * 0.1165093,
      size.width * 0.6840154,
      size.height * 0.1150321,
    );
    path_0.cubicTo(
      size.width * 0.6778590,
      size.height * 0.1118377,
      size.width * 0.6713205,
      size.height * 0.1104815,
      size.width * 0.6673821,
      size.height * 0.08848148,
    );
    path_0.lineTo(size.width * 0.6638000, size.height * 0.09369568);
    path_0.cubicTo(
      size.width * 0.6649744,
      size.height * 0.09641481,
      size.width * 0.6661026,
      size.height * 0.09934259,
      size.width * 0.6671769,
      size.height * 0.1024654,
    );
    path_0.cubicTo(
      size.width * 0.6672974,
      size.height * 0.1028568,
      size.width * 0.6666615,
      size.height * 0.1077691,
      size.width * 0.6663256,
      size.height * 0.1078296,
    );
    path_0.cubicTo(
      size.width * 0.6652641,
      size.height * 0.1077179,
      size.width * 0.6642128,
      size.height * 0.1071920,
      size.width * 0.6631923,
      size.height * 0.1062623,
    );
    path_0.lineTo(size.width * 0.6617410, size.height * 0.1167802);
    path_0.cubicTo(
      size.width * 0.6611718,
      size.height * 0.1122296,
      size.width * 0.6608051,
      size.height * 0.1095173,
      size.width * 0.6604590,
      size.height * 0.1066543,
    );
    path_0.lineTo(size.width * 0.6422179, size.height * 0.1434512);
    path_0.cubicTo(
      size.width * 0.6427231,
      size.height * 0.1339883,
      size.width * 0.6430410,
      size.height * 0.1279006,
      size.width * 0.6433231,
      size.height * 0.1225667,
    );
    path_0.lineTo(size.width * 0.6368385, size.height * 0.1225667);
    path_0.cubicTo(
      size.width * 0.6368385,
      size.height * 0.1235309,
      size.width * 0.6368385,
      size.height * 0.1245253,
      size.width * 0.6368385,
      size.height * 0.1255802,
    );
    path_0.lineTo(size.width * 0.6391487, size.height * 0.1288648);
    path_0.lineTo(size.width * 0.6387282, size.height * 0.1332648);
    path_0.lineTo(size.width * 0.6307385, size.height * 0.1251883);
    path_0.lineTo(size.width * 0.6308051, size.height * 0.1205173);
    path_0.cubicTo(
      size.width * 0.6272513,
      size.height * 0.1246759,
      size.width * 0.6237513,
      size.height * 0.1313667,
      size.width * 0.6201308,
      size.height * 0.1322401,
    );
    path_0.cubicTo(
      size.width * 0.6165103,
      size.height * 0.1331142,
      size.width * 0.6128154,
      size.height * 0.1282019,
      size.width * 0.6092974,
      size.height * 0.1259117,
    );
    path_0.cubicTo(
      size.width * 0.6092974,
      size.height * 0.1276895,
      size.width * 0.6095333,
      size.height * 0.1312759,
      size.width * 0.6091385,
      size.height * 0.1325420,
    );
    path_0.cubicTo(
      size.width * 0.6070256,
      size.height * 0.1394735,
      size.width * 0.6000846,
      size.height * 0.1385691,
      size.width * 0.5975487,
      size.height * 0.1325420,
    );
    path_0.cubicTo(
      size.width * 0.5951538,
      size.height * 0.1269667,
      size.width * 0.5924795,
      size.height * 0.1228377,
      size.width * 0.5899256,
      size.height * 0.1180457,
    );
    path_0.cubicTo(
      size.width * 0.5901128,
      size.height * 0.1142790,
      size.width * 0.5904205,
      size.height * 0.1084019,
      size.width * 0.5907487,
      size.height * 0.1019531,
    );
    path_0.lineTo(size.width * 0.5948077, size.height * 0.09291173);
    path_0.lineTo(size.width * 0.5863333, size.height * 0.08046543);
    path_0.lineTo(size.width * 0.5902154, size.height * 0.07600494);
    path_0.cubicTo(
      size.width * 0.5865282,
      size.height * 0.07374506,
      size.width * 0.5848436,
      size.height * 0.05189562,
      size.width * 0.5800462,
      size.height * 0.06654198,
    );
    path_0.cubicTo(
      size.width * 0.5820846,
      size.height * 0.04131759,
      size.width * 0.5812154,
      size.height * 0.03179432,
      size.width * 0.5765667,
      size.height * 0.03529025,
    );
    path_0.cubicTo(
      size.width * 0.5812436,
      size.height * 0.04433123,
      size.width * 0.5779872,
      size.height * 0.05403531,
      size.width * 0.5775026,
      size.height * 0.06373951,
    );
    path_0.lineTo(size.width * 0.5738718, size.height * 0.06292593);
    path_0.cubicTo(
      size.width * 0.5764821,
      size.height * 0.08420247,
      size.width * 0.5826564,
      size.height * 0.09544321,
      size.width * 0.5840308,
      size.height * 0.1164185,
    );
    path_0.lineTo(size.width * 0.5869590, size.height * 0.1269364);
    path_0.lineTo(size.width * 0.5825154, size.height * 0.1278704);
    path_0.lineTo(size.width * 0.5840308, size.height * 0.1405580);
    path_0.lineTo(size.width * 0.5833487, size.height * 0.1415525);
    path_0.cubicTo(
      size.width * 0.5825718,
      size.height * 0.1373636,
      size.width * 0.5817949,
      size.height * 0.1331444,
      size.width * 0.5805410,
      size.height * 0.1262432,
    );
    path_0.lineTo(size.width * 0.5798410, size.height * 0.1432099);
    path_0.lineTo(size.width * 0.5767051, size.height * 0.1442049);
    path_0.cubicTo(
      size.width * 0.5754538,
      size.height * 0.1391716,
      size.width * 0.5743205,
      size.height * 0.1345611,
      size.width * 0.5731795,
      size.height * 0.1299500,
    );
    path_0.lineTo(size.width * 0.5724769, size.height * 0.1317278);
    path_0.lineTo(size.width * 0.5741615, size.height * 0.1422759);
    path_0.cubicTo(
      size.width * 0.5687256,
      size.height * 0.1286543,
      size.width * 0.5627308,
      size.height * 0.1307636,
      size.width * 0.5566205,
      size.height * 0.1305827,
    );
    path_0.cubicTo(
      size.width * 0.5564333,
      size.height * 0.1291963,
      size.width * 0.5560872,
      size.height * 0.1265444,
      size.width * 0.5557410,
      size.height * 0.1239228,
    );
    path_0.cubicTo(
      size.width * 0.5554179,
      size.height * 0.1249506,
      size.width * 0.5552333,
      size.height * 0.1263469,
      size.width * 0.5552282,
      size.height * 0.1278105,
    );
    path_0.cubicTo(
      size.width * 0.5549385,
      size.height * 0.1313963,
      size.width * 0.5545821,
      size.height * 0.1348926,
      size.width * 0.5542923,
      size.height * 0.1384185,
    );
    path_0.lineTo(size.width * 0.5531692, size.height * 0.1368512);
    path_0.cubicTo(
      size.width * 0.5532462,
      size.height * 0.1355827,
      size.width * 0.5533846,
      size.height * 0.1343617,
      size.width * 0.5535821,
      size.height * 0.1332352,
    );
    path_0.cubicTo(
      size.width * 0.5539692,
      size.height * 0.1320648,
      size.width * 0.5543974,
      size.height * 0.1310525,
      size.width * 0.5548615,
      size.height * 0.1302210,
    );
    path_0.lineTo(size.width * 0.5465744, size.height * 0.1095173);
    path_0.lineTo(size.width * 0.5495385, size.height * 0.1107228);
    path_0.lineTo(size.width * 0.5499051, size.height * 0.1084926);
    path_0.lineTo(size.width * 0.5444410, size.height * 0.09658827);
    path_0.lineTo(size.width * 0.5456282, size.height * 0.09122407);
    path_0.lineTo(size.width * 0.5428231, size.height * 0.08902407);
    path_0.cubicTo(
      size.width * 0.5421410,
      size.height * 0.08109815,
      size.width * 0.5420744,
      size.height * 0.07223765,
      size.width * 0.5411103,
      size.height * 0.07094198,
    );
    path_0.cubicTo(
      size.width * 0.5395769,
      size.height * 0.06883272,
      size.width * 0.5374436,
      size.height * 0.07172593,
      size.width * 0.5352256,
      size.height * 0.07262963,
    );
    path_0.lineTo(size.width * 0.5347026, size.height * 0.06931481);
    path_0.lineTo(size.width * 0.5294744, size.height * 0.08055556);
    path_0.cubicTo(
      size.width * 0.5290795,
      size.height * 0.07437778,
      size.width * 0.5285949,
      size.height * 0.06663272,
      size.width * 0.5280974,
      size.height * 0.05891747,
    );
    path_0.cubicTo(
      size.width * 0.5242154,
      size.height * 0.05174494,
      size.width * 0.5242154,
      size.height * 0.05174494,
      size.width * 0.5219154,
      size.height * 0.06361914,
    );
    path_0.cubicTo(
      size.width * 0.5300641,
      size.height * 0.05484901,
      size.width * 0.5244590,
      size.height * 0.07980247,
      size.width * 0.5271077,
      size.height * 0.08601049,
    );
    path_0.cubicTo(
      size.width * 0.5230385,
      size.height * 0.07862716,
      size.width * 0.5241974,
      size.height * 0.08971728,
      size.width * 0.5241128,
      size.height * 0.09655864,
    );
    path_0.lineTo(size.width * 0.5155436, size.height * 0.09227901);
    path_0.lineTo(size.width * 0.5125590, size.height * 0.1045444);
    path_0.lineTo(size.width * 0.5090231, size.height * 0.09366543);
    path_0.lineTo(size.width * 0.5112026, size.height * 0.07901852);
    path_0.lineTo(size.width * 0.5051513, size.height * 0.09022963);
    path_0.lineTo(size.width * 0.5034667, size.height * 0.08167099);
    path_0.lineTo(size.width * 0.5014846, size.height * 0.09818580);
    path_0.cubicTo(
      size.width * 0.4975538,
      size.height * 0.09333395,
      size.width * 0.4924846,
      size.height * 0.1092160,
      size.width * 0.4892769,
      size.height * 0.08805988,
    );
    path_0.lineTo(size.width * 0.4954769, size.height * 0.09514198);
    path_0.cubicTo(
      size.width * 0.4956641,
      size.height * 0.09357469,
      size.width * 0.4958513,
      size.height * 0.09212840,
      size.width * 0.4960308,
      size.height * 0.09047099,
    );
    path_0.lineTo(size.width * 0.4903410, size.height * 0.07407654);
    path_0.lineTo(size.width * 0.4920538, size.height * 0.06949568);
    path_0.cubicTo(
      size.width * 0.4912410,
      size.height * 0.06512593,
      size.width * 0.4904923,
      size.height * 0.06108735,
      size.width * 0.4896128,
      size.height * 0.05629556,
    );
    path_0.lineTo(size.width * 0.4846462, size.height * 0.05527093);
    path_0.lineTo(size.width * 0.4846462, size.height * 0.04038333);
    path_0.cubicTo(
      size.width * 0.4815103,
      size.height * 0.03134228,
      size.width * 0.4755051,
      size.height * 0.04303537,
      size.width * 0.4749718,
      size.height * 0.02007111,
    );
    path_0.lineTo(size.width * 0.4691538, size.height * 0.02646012);
    path_0.cubicTo(size.width * 0.4677308, size.height * 0.01886568, size.width * 0.4695282, size.height * 0.003013679, size.width * 0.4638692, 0);
    path_0.lineTo(size.width * 0.4623436, size.height * 0.007142407);
    path_0.cubicTo(
      size.width * 0.4637179,
      size.height * 0.009613642,
      size.width * 0.4655231,
      size.height * 0.01081914,
      size.width * 0.4659359,
      size.height * 0.01404377,
    );
    path_0.cubicTo(
      size.width * 0.4665718,
      size.height * 0.01916704,
      size.width * 0.4662821,
      size.height * 0.02567654,
      size.width * 0.4663949,
      size.height * 0.03194500,
    );
    path_0.lineTo(size.width * 0.4640923, size.height * 0.03058889);
    path_0.cubicTo(
      size.width * 0.4639897,
      size.height * 0.04231210,
      size.width * 0.4653846,
      size.height * 0.04607920,
      size.width * 0.4683308,
      size.height * 0.04565728,
    );
    path_0.cubicTo(
      size.width * 0.4704256,
      size.height * 0.05053944,
      size.width * 0.4716615,
      size.height * 0.05530105,
      size.width * 0.4731667,
      size.height * 0.05656679,
    );
    path_0.cubicTo(
      size.width * 0.4793308,
      size.height * 0.06178025,
      size.width * 0.4803974,
      size.height * 0.06536667,
      size.width * 0.4805205,
      size.height * 0.08516667,
    );
    path_0.cubicTo(
      size.width * 0.4863103,
      size.height * 0.09267099,
      size.width * 0.4863103,
      size.height * 0.09267099,
      size.width * 0.4851026,
      size.height * 0.1055093,
    );
    path_0.lineTo(size.width * 0.4822513, size.height * 0.1055093);
    path_0.lineTo(size.width * 0.4822513, size.height * 0.09116358);
    path_0.lineTo(size.width * 0.4752154, size.height * 0.09625679);
    path_0.lineTo(size.width * 0.4729513, size.height * 0.08890370);
    path_0.lineTo(size.width * 0.4739795, size.height * 0.08652284);
    path_0.cubicTo(
      size.width * 0.4732410,
      size.height * 0.08281605,
      size.width * 0.4727282,
      size.height * 0.07802407,
      size.width * 0.4717256,
      size.height * 0.07558333,
    );
    path_0.cubicTo(
      size.width * 0.4689205,
      size.height * 0.06883272,
      size.width * 0.4647846,
      size.height * 0.06521605,
      size.width * 0.4634103,
      size.height * 0.05632574,
    );
    path_0.cubicTo(
      size.width * 0.4617154,
      size.height * 0.04535593,
      size.width * 0.4592846,
      size.height * 0.04671210,
      size.width * 0.4569641,
      size.height * 0.04387920,
    );
    path_0.cubicTo(
      size.width * 0.4532231,
      size.height * 0.03923815,
      size.width * 0.4494231,
      size.height * 0.03465735,
      size.width * 0.4456718,
      size.height * 0.03007654,
    );
    path_0.lineTo(size.width * 0.4379641, size.height * 0.03462722);
    path_0.lineTo(size.width * 0.4332872, size.height * 0.05629556);
    path_0.lineTo(size.width * 0.4237641, size.height * 0.05216685);
    path_0.cubicTo(
      size.width * 0.4234821,
      size.height * 0.05050932,
      size.width * 0.4228282,
      size.height * 0.04668191,
      size.width * 0.4222026,
      size.height * 0.04312580,
    );
    path_0.lineTo(size.width * 0.4158487, size.height * 0.05725994);
    path_0.cubicTo(
      size.width * 0.4144462,
      size.height * 0.04969562,
      size.width * 0.4127436,
      size.height * 0.04348741,
      size.width * 0.4121077,
      size.height * 0.03616420,
    );
    path_0.cubicTo(
      size.width * 0.4111718,
      size.height * 0.02603821,
      size.width * 0.4096000,
      size.height * 0.02633957,
      size.width * 0.4071128,
      size.height * 0.02763549,
    );
    path_0.cubicTo(
      size.width * 0.4035026,
      size.height * 0.02953407,
      size.width * 0.3994974,
      size.height * 0.03616420,
      size.width * 0.3972513,
      size.height * 0.02462179,
    );
    path_0.cubicTo(
      size.width * 0.3945949,
      size.height * 0.02305469,
      size.width * 0.3925744,
      size.height * 0.02323549,
      size.width * 0.3909667,
      size.height * 0.02061358,
    );
    path_0.cubicTo(
      size.width * 0.3862897,
      size.height * 0.01295883,
      size.width * 0.3831077,
      size.height * 0.01648481,
      size.width * 0.3802923,
      size.height * 0.03233679,
    );
    path_0.cubicTo(
      size.width * 0.3786538,
      size.height * 0.04152852,
      size.width * 0.3768205,
      size.height * 0.05108191,
      size.width * 0.3727436,
      size.height * 0.04830932,
    );
    path_0.cubicTo(
      size.width * 0.3719205,
      size.height * 0.04773673,
      size.width * 0.3708718,
      size.height * 0.05059975,
      size.width * 0.3700026,
      size.height * 0.05183531,
    );
    path_0.lineTo(size.width * 0.3685692, size.height * 0.04339704);
    path_0.lineTo(size.width * 0.3676923, size.height * 0.04375864);
    path_0.lineTo(size.width * 0.3672231, size.height * 0.05608463);
    path_0.lineTo(size.width * 0.3649410, size.height * 0.05183531);
    path_0.lineTo(size.width * 0.3621897, size.height * 0.06178025);
    path_0.cubicTo(
      size.width * 0.3620128,
      size.height * 0.05557228,
      size.width * 0.3618923,
      size.height * 0.05129284,
      size.width * 0.3617590,
      size.height * 0.04698333,
    );
    path_0.lineTo(size.width * 0.3610410, size.height * 0.04680247);
    path_0.lineTo(size.width * 0.3600564, size.height * 0.05756136);
    path_0.lineTo(size.width * 0.3561744, size.height * 0.04821889);
    path_0.cubicTo(
      size.width * 0.3564103,
      size.height * 0.05355315,
      size.width * 0.3565487,
      size.height * 0.05680790,
      size.width * 0.3567923,
      size.height * 0.06253395,
    );
    path_0.cubicTo(
      size.width * 0.3548282,
      size.height * 0.05909833,
      size.width * 0.3535744,
      size.height * 0.05548191,
      size.width * 0.3522282,
      size.height * 0.05499969,
    );
    path_0.cubicTo(
      size.width * 0.3508795,
      size.height * 0.05451753,
      size.width * 0.3493462,
      size.height * 0.05738049,
      size.width * 0.3478692,
      size.height * 0.05801340,
    );
    path_0.cubicTo(
      size.width * 0.3470641,
      size.height * 0.05816519,
      size.width * 0.3462590,
      size.height * 0.05783827,
      size.width * 0.3454923,
      size.height * 0.05704901,
    );
    path_0.cubicTo(
      size.width * 0.3423385,
      size.height * 0.05484901,
      size.width * 0.3390179,
      size.height * 0.04924358,
      size.width * 0.3360718,
      size.height * 0.05102167,
    );
    path_0.cubicTo(
      size.width * 0.3307103,
      size.height * 0.05418599,
      size.width * 0.3255744,
      size.height * 0.06165994,
      size.width * 0.3203564,
      size.height * 0.06744630,
    );
    path_0.cubicTo(
      size.width * 0.3172590,
      size.height * 0.07088210,
      size.width * 0.3141821,
      size.height * 0.07455864,
      size.width * 0.3116923,
      size.height * 0.07742160,
    );
    path_0.lineTo(size.width * 0.3090744, size.height * 0.04978605);
    path_0.lineTo(size.width * 0.3034615, size.height * 0.05581340);
    path_0.cubicTo(
      size.width * 0.3052846,
      size.height * 0.05933938,
      size.width * 0.3064256,
      size.height * 0.06156951,
      size.width * 0.3079051,
      size.height * 0.06449259,
    );
    path_0.cubicTo(
      size.width * 0.3079051,
      size.height * 0.06530679,
      size.width * 0.3078487,
      size.height * 0.06832037,
      size.width * 0.3078564,
      size.height * 0.06765741,
    );
    path_0.cubicTo(
      size.width * 0.3041154,
      size.height * 0.06865185,
      size.width * 0.3006641,
      size.height * 0.06841049,
      size.width * 0.2973897,
      size.height * 0.07067099,
    );
    path_0.cubicTo(
      size.width * 0.2938077,
      size.height * 0.07320247,
      size.width * 0.2903538,
      size.height * 0.07808457,
      size.width * 0.2855846,
      size.height * 0.08332840,
    );
    path_0.cubicTo(
      size.width * 0.2878949,
      size.height * 0.06759691,
      size.width * 0.2854897,
      size.height * 0.06892284,
      size.width * 0.2834872,
      size.height * 0.06774753,
    );
    path_0.cubicTo(
      size.width * 0.2793718,
      size.height * 0.06539691,
      size.width * 0.2753308,
      size.height * 0.06066543,
      size.width * 0.2712154,
      size.height * 0.05991198,
    );
    path_0.cubicTo(
      size.width * 0.2670974,
      size.height * 0.05915858,
      size.width * 0.2627949,
      size.height * 0.06156951,
      size.width * 0.2586410,
      size.height * 0.06355864,
    );
    path_0.cubicTo(
      size.width * 0.2549933,
      size.height * 0.06527654,
      size.width * 0.2514197,
      size.height * 0.06958580,
      size.width * 0.2477621,
      size.height * 0.07039938,
    );
    path_0.cubicTo(
      size.width * 0.2447031,
      size.height * 0.07103272,
      size.width * 0.2415785,
      size.height * 0.06819938,
      size.width * 0.2384821,
      size.height * 0.06693395,
    );
    path_0.lineTo(size.width * 0.2378367, size.height * 0.07055000);
    path_0.lineTo(size.width * 0.2345626, size.height * 0.05246821);
    path_0.cubicTo(
      size.width * 0.2290618,
      size.height * 0.04448198,
      size.width * 0.2226351,
      size.height * 0.05671747,
      size.width * 0.2170221,
      size.height * 0.04421074,
    );
    path_0.cubicTo(
      size.width * 0.2156377,
      size.height * 0.04119704,
      size.width * 0.2129433,
      size.height * 0.03854500,
      size.width * 0.2119238,
      size.height * 0.04098605,
    );
    path_0.cubicTo(
      size.width * 0.2080228,
      size.height * 0.05026821,
      size.width * 0.2043651,
      size.height * 0.04077512,
      size.width * 0.2006979,
      size.height * 0.04047377,
    );
    path_0.cubicTo(
      size.width * 0.1953469,
      size.height * 0.03999154,
      size.width * 0.1894254,
      size.height * 0.04918327,
      size.width * 0.1876013,
      size.height * 0.06732593,
    );
    path_0.lineTo(size.width * 0.1823813, size.height * 0.06129827);
    path_0.lineTo(size.width * 0.1845703, size.height * 0.05725994);
    path_0.lineTo(size.width * 0.1846264, size.height * 0.05316136);
    path_0.lineTo(size.width * 0.1737000, size.height * 0.04864080);
    path_0.cubicTo(
      size.width * 0.1735782,
      size.height * 0.05053944,
      size.width * 0.1733444,
      size.height * 0.05391475,
      size.width * 0.1731387,
      size.height * 0.05692846,
    );
    path_0.lineTo(size.width * 0.1704164, size.height * 0.05536136);
    path_0.lineTo(size.width * 0.1698177, size.height * 0.05813395);
    path_0.lineTo(size.width * 0.1739900, size.height * 0.07639691);
    path_0.cubicTo(
      size.width * 0.1707905,
      size.height * 0.07253951,
      size.width * 0.1684331,
      size.height * 0.07036975,
      size.width * 0.1662628,
      size.height * 0.06687346,
    );
    path_0.cubicTo(
      size.width * 0.1632131,
      size.height * 0.06202160,
      size.width * 0.1611269,
      size.height * 0.06385988,
      size.width * 0.1602477,
      size.height * 0.07621605,
    );
    path_0.cubicTo(
      size.width * 0.1588726,
      size.height * 0.07018889,
      size.width * 0.1580492,
      size.height * 0.06379938,
      size.width * 0.1566179,
      size.height * 0.06114759,
    );
    path_0.cubicTo(
      size.width * 0.1555795,
      size.height * 0.05918870,
      size.width * 0.1538115,
      size.height * 0.06184074,
      size.width * 0.1523146,
      size.height * 0.06253395,
    );
    path_0.lineTo(size.width * 0.1491062, size.height * 0.05801340);
    path_0.cubicTo(
      size.width * 0.1486103,
      size.height * 0.07359383,
      size.width * 0.1465803,
      size.height * 0.08308704,
      size.width * 0.1415192,
      size.height * 0.07962160,
    );
    path_0.cubicTo(
      size.width * 0.1418279,
      size.height * 0.07600494,
      size.width * 0.1421274,
      size.height * 0.07238889,
      size.width * 0.1424549,
      size.height * 0.06880247,
    );
    path_0.lineTo(size.width * 0.1412479, size.height * 0.06536667);
    path_0.cubicTo(
      size.width * 0.1407708,
      size.height * 0.06838025,
      size.width * 0.1403126,
      size.height * 0.07139383,
      size.width * 0.1404062,
      size.height * 0.07085185,
    );
    path_0.lineTo(size.width * 0.1270567, size.height * 0.06717469);
    path_0.cubicTo(
      size.width * 0.1267479,
      size.height * 0.07238889,
      size.width * 0.1264954,
      size.height * 0.07654753,
      size.width * 0.1262523,
      size.height * 0.08079691,
    );
    path_0.cubicTo(
      size.width * 0.1215187,
      size.height * 0.08200247,
      size.width * 0.1168974,
      size.height * 0.08236420,
      size.width * 0.1124351,
      size.height * 0.08450370,
    );
    path_0.cubicTo(
      size.width * 0.1069654,
      size.height * 0.08684568,
      size.width * 0.1019287,
      size.height * 0.09534259,
      size.width * 0.09821564,
      size.height * 0.1084926,
    );
    path_0.cubicTo(
      size.width * 0.09617641,
      size.height * 0.1155747,
      size.width * 0.09329513,
      size.height * 0.1199747,
      size.width * 0.09073179,
      size.height * 0.1250377,
    );
    path_0.cubicTo(
      size.width * 0.08816872,
      size.height * 0.1301006,
      size.width * 0.08532487,
      size.height * 0.1349525,
      size.width * 0.08255564,
      size.height * 0.1394735,
    );
    path_0.cubicTo(
      size.width * 0.08071821,
      size.height * 0.1425494,
      size.width * 0.07881051,
      size.height * 0.1451685,
      size.width * 0.07684923,
      size.height * 0.1473086,
    );
    path_0.cubicTo(
      size.width * 0.07546923,
      size.height * 0.1485802,
      size.width * 0.07406231,
      size.height * 0.1495272,
      size.width * 0.07263974,
      size.height * 0.1501414,
    );
    path_0.cubicTo(
      size.width * 0.07021667,
      size.height * 0.1417031,
      size.width * 0.06801846,
      size.height * 0.1340488,
      size.width * 0.06534282,
      size.height * 0.1247963,
    );
    path_0.cubicTo(
      size.width * 0.06480026,
      size.height * 0.1320296,
      size.width * 0.06451974,
      size.height * 0.1357062,
      size.width * 0.06423897,
      size.height * 0.1394130,
    );
    path_0.lineTo(size.width * 0.06309769, size.height * 0.1394130);
    path_0.cubicTo(
      size.width * 0.06292000,
      size.height * 0.1346210,
      size.width * 0.06273282,
      size.height * 0.1298593,
      size.width * 0.06245231,
      size.height * 0.1224457,
    );
    path_0.lineTo(size.width * 0.05641846, size.height * 0.1361278);
    path_0.cubicTo(
      size.width * 0.05654000,
      size.height * 0.1331142,
      size.width * 0.05664282,
      size.height * 0.1303716,
      size.width * 0.05676436,
      size.height * 0.1273278,
    );
    path_0.lineTo(size.width * 0.05349026, size.height * 0.1273278);
    path_0.cubicTo(
      size.width * 0.05393000,
      size.height * 0.1325716,
      size.width * 0.05426667,
      size.height * 0.1367309,
      size.width * 0.05461282,
      size.height * 0.1408895,
    );
    path_0.lineTo(size.width * 0.05358385, size.height * 0.1427580);
    path_0.lineTo(size.width * 0.05137615, size.height * 0.1291963);
    path_0.lineTo(size.width * 0.04608128, size.height * 0.1302815);
    path_0.lineTo(size.width * 0.04608128, size.height * 0.1138568);
    path_0.cubicTo(
      size.width * 0.04460308,
      size.height * 0.1166599,
      size.width * 0.04304103,
      size.height * 0.1183475,
      size.width * 0.04305026,
      size.height * 0.1198846,
    );
    path_0.cubicTo(
      size.width * 0.04309718,
      size.height * 0.1245858,
      size.width * 0.04374256,
      size.height * 0.1292265,
      size.width * 0.04436923,
      size.height * 0.1362185,
    );
    path_0.lineTo(size.width * 0.03711923, size.height * 0.1214210);
    path_0.cubicTo(
      size.width * 0.03650179,
      size.height * 0.1274488,
      size.width * 0.03597795,
      size.height * 0.1324210,
      size.width * 0.03537923,
      size.height * 0.1381173,
    );
    path_0.lineTo(size.width * 0.03145026, size.height * 0.1362185);
    path_0.cubicTo(
      size.width * 0.03051487,
      size.height * 0.1271772,
      size.width * 0.02972897,
      size.height * 0.1189500,
      size.width * 0.02891513,
      size.height * 0.1108735,
    );
    path_0.lineTo(size.width * 0.02791410, size.height * 0.1120488);
    path_0.cubicTo(
      size.width * 0.02805462,
      size.height * 0.1159667,
      size.width * 0.02819487,
      size.height * 0.1198846,
      size.width * 0.02822282,
      size.height * 0.1206074,
    );
    path_0.cubicTo(
      size.width * 0.02624897,
      size.height * 0.1263938,
      size.width * 0.02459321,
      size.height * 0.1298296,
      size.width * 0.02354546,
      size.height * 0.1347420,
    );
    path_0.cubicTo(
      size.width * 0.02249772,
      size.height * 0.1396543,
      size.width * 0.02175869,
      size.height * 0.1467963,
      size.width * 0.02034610,
      size.height * 0.1569525,
    );
    path_0.cubicTo(
      size.width * 0.01952290,
      size.height * 0.1436019,
      size.width * 0.01780159,
      size.height * 0.1426679,
      size.width * 0.01473321,
      size.height * 0.1431500,
    );
    path_0.cubicTo(
      size.width * 0.01240385,
      size.height * 0.1435117,
      size.width * 0.008465487,
      size.height * 0.1431500,
      size.width * 0.006996769,
      size.height * 0.1300704,
    );
    path_0.cubicTo(
      size.width * 0.006688077,
      size.height * 0.1272074,
      size.width * 0.003600949,
      size.height * 0.1247364,
      size.width * 0.002469023,
      size.height * 0.1266648,
    );
    path_0.cubicTo(
      size.width * -0.001822200,
      size.height * 0.1338327,
      size.width * -0.005894000,
      size.height * 0.1422883,
      size.width * -0.009692256,
      size.height * 0.1519198,
    );
    path_0.cubicTo(
      size.width * -0.01083354,
      size.height * 0.1549333,
      size.width * -0.01068387,
      size.height * 0.1636728,
      size.width * -0.01109549,
      size.height * 0.1698210,
    );
    path_0.cubicTo(
      size.width * -0.01137613,
      size.height * 0.1740099,
      size.width * -0.01161000,
      size.height * 0.1782290,
      size.width * -0.01186256,
      size.height * 0.1824481,
    );
    path_0.lineTo(size.width * -0.01318162, size.height * 0.1818457);
    path_0.cubicTo(
      size.width * -0.01342485,
      size.height * 0.1732864,
      size.width * -0.01440710,
      size.height * 0.1639747,
      size.width * -0.01372418,
      size.height * 0.1563802,
    );
    path_0.cubicTo(
      size.width * -0.01257354,
      size.height * 0.1435420,
      size.width * -0.01465967,
      size.height * 0.1436623,
      size.width * -0.01653064,
      size.height * 0.1436019,
    );
    path_0.lineTo(size.width * -0.01866354, size.height * 0.1265747);
    path_0.lineTo(size.width * -0.02030064, size.height * 0.1272679);
    path_0.cubicTo(
      size.width * -0.02059064,
      size.height * 0.1440241,
      size.width * -0.02087128,
      size.height * 0.1608099,
      size.width * -0.02117997,
      size.height * 0.1789827,
    );
    path_0.lineTo(size.width * -0.02409869, size.height * 0.1814840);
    path_0.cubicTo(
      size.width * -0.02453838,
      size.height * 0.1774457,
      size.width * -0.02495000,
      size.height * 0.1736481,
      size.width * -0.02565154,
      size.height * 0.1671086,
    );
    path_0.cubicTo(
      size.width * -0.02674615,
      size.height * 0.1712673,
      size.width * -0.02819615,
      size.height * 0.1747636,
      size.width * -0.02803718,
      size.height * 0.1765414,
    );
    path_0.cubicTo(
      size.width * -0.02752256,
      size.height * 0.1819660,
      size.width * -0.02640000,
      size.height * 0.1867278,
      size.width * -0.02492192,
      size.height * 0.1951358,
    );
    path_0.cubicTo(
      size.width * -0.02632513,
      size.height * 0.2037549,
      size.width * -0.02823359,
      size.height * 0.2153877,
      size.width * -0.02985179,
      size.height * 0.2252728,
    );
    path_0.lineTo(size.width * -0.03555846, size.height * 0.2342235);
    path_0.lineTo(size.width * -0.03186333, size.height * 0.2432642);
    path_0.lineTo(size.width * -0.03541795, size.height * 0.2572179);
    path_0.cubicTo(
      size.width * -0.03629744,
      size.height * 0.2511901,
      size.width * -0.03716744,
      size.height * 0.2451630,
      size.width * -0.03802795,
      size.height * 0.2389549,
    );
    path_0.lineTo(size.width * -0.03912256, size.height * 0.2391957);
    path_0.cubicTo(
      size.width * -0.03938462,
      size.height * 0.2490204,
      size.width * -0.02930923,
      size.height * 0.2588148,
      size.width * -0.02960872,
      size.height * 0.2700259,
    );
    path_0.cubicTo(
      size.width * -0.03281744,
      size.height * 0.2637574,
      size.width * -0.03442641,
      size.height * 0.2663494,
      size.width * -0.03677462,
      size.height * 0.2730395,
    );
    path_0.cubicTo(
      size.width * -0.04019846,
      size.height * 0.2828642,
      size.width * -0.04457641,
      size.height * 0.2886204,
      size.width * -0.04774769,
      size.height * 0.3004037,
    );
    path_0.cubicTo(
      size.width * -0.04969359,
      size.height * 0.3076364,
      size.width * -0.05257487,
      size.height * 0.3120667,
      size.width * -0.05429615,
      size.height * 0.3196611,
    );
    path_0.cubicTo(
      size.width * -0.05641974,
      size.height * 0.3287025,
      size.width * -0.05780410,
      size.height * 0.3400340,
      size.width * -0.05968436,
      size.height * 0.3514253,
    );
    path_0.lineTo(size.width * -0.06203256, size.height * 0.3440117);
    path_0.lineTo(size.width * -0.05894538, size.height * 0.3271049);
    path_0.lineTo(size.width * -0.06243487, size.height * 0.3224642);
    path_0.lineTo(size.width * -0.06450231, size.height * 0.3347901);
    path_0.lineTo(size.width * -0.07036769, size.height * 0.3247846);
    path_0.cubicTo(
      size.width * -0.07375410,
      size.height * 0.3396722,
      size.width * -0.07277179,
      size.height * 0.3511846,
      size.width * -0.06849667,
      size.height * 0.3606475,
    );
    path_0.lineTo(size.width * -0.07847846, size.height * 0.3579654);
    path_0.lineTo(size.width * -0.07905846, size.height * 0.3616420);
    path_0.lineTo(size.width * -0.07444641, size.height * 0.3810802);
    path_0.lineTo(size.width * -0.07484872, size.height * 0.3848469);
    path_0.cubicTo(
      size.width * -0.08156538,
      size.height * 0.3630580,
      size.width * -0.08564410,
      size.height * 0.3845457,
      size.width * -0.09059282,
      size.height * 0.3944309,
    );
    path_0.cubicTo(
      size.width * -0.08982897,
      size.height * 0.3844981,
      size.width * -0.08865564,
      size.height * 0.3749401,
      size.width * -0.08710359,
      size.height * 0.3660117,
    );
    path_0.cubicTo(
      size.width * -0.08605564,
      size.height * 0.3604062,
      size.width * -0.08321179,
      size.height * 0.3563074,
      size.width * -0.08536359,
      size.height * 0.3488340,
    );
    path_0.cubicTo(
      size.width * -0.08787051,
      size.height * 0.3401543,
      size.width * -0.08898385,
      size.height * 0.3526611,
      size.width * -0.09077051,
      size.height * 0.3553735,
    );
    path_0.cubicTo(
      size.width * -0.09097641,
      size.height * 0.3557049,
      size.width * -0.09107923,
      size.height * 0.3569105,
      size.width * -0.09121974,
      size.height * 0.3577241,
    );
    path_0.cubicTo(
      size.width * -0.09028410,
      size.height * 0.3767105,
      size.width * -0.09066769,
      size.height * 0.3776444,
      size.width * -0.09903103,
      size.height * 0.3767105,
    );
    path_0.cubicTo(
      size.width * -0.09985410,
      size.height * 0.3817432,
      size.width * -0.1006679,
      size.height * 0.3867154,
      size.width * -0.1016690,
      size.height * 0.3928938,
    );
    path_0.lineTo(size.width * -0.09231410, size.height * 0.4009401);
    path_0.lineTo(size.width * -0.09400744, size.height * 0.4134167);
    path_0.cubicTo(
      size.width * -0.09892795,
      size.height * 0.4124827,
      size.width * -0.1034464,
      size.height * 0.4112469,
      size.width * -0.1079649,
      size.height * 0.4108852,
    );
    path_0.cubicTo(
      size.width * -0.1136900,
      size.height * 0.4104031,
      size.width * -0.1146441,
      size.height * 0.4138994,
      size.width * -0.1150556,
      size.height * 0.4300525,
    );
    path_0.lineTo(size.width * -0.1085823, size.height * 0.4364414);
    path_0.cubicTo(
      size.width * -0.1085823,
      size.height * 0.4378278,
      size.width * -0.1086569,
      size.height * 0.4392142,
      size.width * -0.1087038,
      size.height * 0.4406000,
    );
    path_0.lineTo(size.width * -0.1158228, size.height * 0.4422877);
    path_0.lineTo(size.width * -0.1174318, size.height * 0.4505753);
    path_0.lineTo(size.width * -0.1179651, size.height * 0.4469290);
    path_0.lineTo(size.width * -0.1256174, size.height * 0.4536796);
    path_0.cubicTo(
      size.width * -0.1196956,
      size.height * 0.4682660,
      size.width * -0.1137274,
      size.height * 0.4694716,
      size.width * -0.1074597,
      size.height * 0.4538302,
    );
    path_0.close();
    path_0.moveTo(size.width * 1.145021, size.height * 0.3717377);
    path_0.cubicTo(
      size.width * 1.143628,
      size.height * 0.3646858,
      size.width * 1.142721,
      size.height * 0.3562475,
      size.width * 1.140951,
      size.height * 0.3522994,
    );
    path_0.cubicTo(
      size.width * 1.139354,
      size.height * 0.3487735,
      size.width * 1.136818,
      size.height * 0.3501901,
      size.width * 1.134695,
      size.height * 0.3492858,
    );
    path_0.cubicTo(
      size.width * 1.134815,
      size.height * 0.3471759,
      size.width * 1.134946,
      size.height * 0.3450667,
      size.width * 1.135077,
      size.height * 0.3429568,
    );
    path_0.lineTo(size.width * 1.147903, size.height * 0.3382858);
    path_0.cubicTo(
      size.width * 1.147079,
      size.height * 0.3482611,
      size.width * 1.146303,
      size.height * 0.3572722,
      size.width * 1.145021,
      size.height * 0.3717377,
    );
    path_0.close();
    path_0.moveTo(size.width * 1.135469, size.height * 0.3126698);
    path_0.lineTo(size.width * 1.136405, size.height * 0.3203846);
    path_0.lineTo(size.width * 1.140456, size.height * 0.3224037);
    path_0.lineTo(size.width * 1.140231, size.height * 0.3265025);
    path_0.lineTo(size.width * 1.133572, size.height * 0.3305105);
    path_0.lineTo(size.width * 1.133131, size.height * 0.3265327);
    path_0.lineTo(size.width * 1.135469, size.height * 0.3126698);
    path_0.close();
    path_0.moveTo(size.width * 0.5351718, size.height * 0.07281049);
    path_0.cubicTo(
      size.width * 0.5352256,
      size.height * 0.07320247,
      size.width * 0.5351718,
      size.height * 0.07317222,
      size.width * 0.5351718,
      size.height * 0.07281049,
    );
    path_0.close();
    path_0.moveTo(size.width * 0.3753256, size.height * 0.8686667);
    path_0.cubicTo(
      size.width * 0.3755308,
      size.height * 0.8702593,
      size.width * 0.3757462,
      size.height * 0.8718580,
      size.width * 0.3759615,
      size.height * 0.8734568,
    );
    path_0.lineTo(size.width * 0.3714795, size.height * 0.8858086);
    path_0.cubicTo(
      size.width * 0.3708821,
      size.height * 0.8821975,
      size.width * 0.3702923,
      size.height * 0.8785802,
      size.width * 0.3693282,
      size.height * 0.8727037,
    );
    path_0.lineTo(size.width * 0.3753256, size.height * 0.8686667);
    path_0.close();
    path_0.moveTo(size.width * 0.1522305, size.height * 0.06256420);
    path_0.lineTo(size.width * 0.1522962, size.height * 0.06256420);
    path_0.lineTo(size.width * 0.1522962, size.height * 0.06274506);
    path_0.cubicTo(
      size.width * 0.1539705,
      size.height * 0.06907346,
      size.width * 0.1556451,
      size.height * 0.07543272,
      size.width * 0.1574692,
      size.height * 0.08227346,
    );
    path_0.cubicTo(
      size.width * 0.1548967,
      size.height * 0.09149568,
      size.width * 0.1526049,
      size.height * 0.08495556,
      size.width * 0.1491995,
      size.height * 0.08016420,
    );
    path_0.lineTo(size.width * 0.1522962, size.height * 0.06274506);
    path_0.lineTo(size.width * 0.1522305, size.height * 0.06256420);
    path_0.close();
    path_0.moveTo(size.width * -0.07989103, size.height * 0.3925019);
    path_0.lineTo(size.width * -0.08540103, size.height * 0.4096802);
    path_0.lineTo(size.width * -0.08690692, size.height * 0.3925019);
    path_0.lineTo(size.width * -0.07989103, size.height * 0.3925019);
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
