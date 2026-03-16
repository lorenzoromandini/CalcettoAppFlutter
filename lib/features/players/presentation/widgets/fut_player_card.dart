import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../clubs/domain/entities/member.dart';
import '../../../../clubs/domain/entities/club.dart';

enum CardType {
  bronzeBase,
  bronzeRare,
  silver,
  golden,
  ifCard,
  playerOfTheMatch,
  playerOfTheMonth,
  ultimateScream,
  absent,
}

class CardSpacesConfig {
  final Map<String, CardTypeConfig> cardTypeConfig;
  final List<Region> regions;
  final LayoutDimensions dimensions;

  CardSpacesConfig({
    required this.cardTypeConfig,
    required this.regions,
    required this.dimensions,
  });

  static Future<CardSpacesConfig> load() async {
    final jsonString = await rootBundle.loadString('assets/card-spaces.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);

    final cardTypeConfigJson = json['cardTypeConfig'] as Map<String, dynamic>;
    final cardTypeConfig = <String, CardTypeConfig>{};

    cardTypeConfigJson.forEach((key, value) {
      cardTypeConfig[key] = CardTypeConfig(
        backgroundImage: value['backgroundImage'] as String,
        textColor: value['textColor'] as String,
      );
    });

    final regionsJson = json['regions'] as List;
    final regions = regionsJson.map((r) => Region.fromJson(r)).toList();

    final dims = json['layout']['dimensions'] as Map<String, dynamic>;
    final dimensions = LayoutDimensions(
      width: dims['width'] as num,
      height: dims['height'] as num,
    );

    return CardSpacesConfig(
      cardTypeConfig: cardTypeConfig,
      regions: regions,
      dimensions: dimensions,
    );
  }
}

class CardTypeConfig {
  final String backgroundImage;
  final String textColor;

  CardTypeConfig({
    required this.backgroundImage,
    required this.textColor,
  });
}

class Region {
  final String id;
  final String purpose;
  final String type;
  final Bounds? bounds;
  final String? dataField;
  final bool optional;
  final int zIndex;

  Region({
    required this.id,
    required this.purpose,
    required this.type,
    this.bounds,
    this.dataField,
    this.optional = false,
    required this.zIndex,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    final boundsJson = json['bounds'] as Map<String, dynamic>?;
    return Region(
      id: json['id'] as String,
      purpose: json['purpose'] as String,
      type: json['type'] as String,
      bounds: boundsJson != null ? Bounds.fromJson(boundsJson) : null,
      dataField: json['dataField'] as String?,
      optional: json['optional'] as bool? ?? false,
      zIndex: json['zIndex'] as int? ?? 10,
    );
  }
}

class Bounds {
  final double x;
  final double y;
  final double width;
  final double height;

  Bounds({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }
}

class LayoutDimensions {
  final double width;
  final double height;

  LayoutDimensions({
    required this.width,
    required this.height,
  });
}

class FutPlayerCard extends StatefulWidget {
  final Member member;
  final CardType? cardType;
  final VoidCallback? onClick;
  final double? lastMatchRating;
  final bool hasMvpInLastMatch;
  final bool isAbsent;
  final bool isGuest;

  const FutPlayerCard({
    super.key,
    required this.member,
    this.cardType,
    this.onClick,
    this.lastMatchRating,
    this.hasMvpInLastMatch = false,
    this.isAbsent = false,
    this.isGuest = false,
  });

  @override
  State<FutPlayerCard> createState() => _FutPlayerCardState();
}

class _FutPlayerCardState extends State<FutPlayerCard> {
  CardSpacesConfig? _config;
  double _scaleFactor = 1.0;

  static const Map<PlayerRole, String> _roleAbbreviations = {
    PlayerRole.por: 'POR',
    PlayerRole.dif: 'DIF',
    PlayerRole.cen: 'CEN',
    PlayerRole.att: 'ATT',
  };

  CardType _getCardType() {
    if (widget.isAbsent) return CardType.absent;
    if (widget.hasMvpInLastMatch) return CardType.playerOfTheMatch;

    final rating = widget.lastMatchRating;
    if (rating != null) {
      if (rating >= 8.0) return CardType.ifCard;
      if (rating >= 7.0) return CardType.golden;
      if (rating >= 6.0) return CardType.silver;
      if (rating > 4.5) return CardType.bronzeRare;
    }

    return CardType.bronzeBase;
  }

  String _getDisplayName() {
    if (widget.isGuest) return 'OSPITE';

    final nickname = widget.member.user?.nickname;
    if (nickname != null && nickname.isNotEmpty) {
      return nickname;
    }

    final firstName = widget.member.user?.firstName ?? '';
    final lastName = widget.member.user?.lastName ?? '';

    if (firstName.isNotEmpty) {
      final initial = firstName[0].toUpperCase();
      return '$initial. $lastName';
    }

    return lastName;
  }

  String _getInitials() {
    if (widget.isGuest) return '';

    final firstName = widget.member.user?.firstName ?? '';
    final lastName = widget.member.user?.lastName ?? '';

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    } else if (firstName.isNotEmpty) {
      return firstName[0].toUpperCase();
    }

    return '?';
  }

  Region? _findRegion(String id) {
    if (_config == null) return null;
    return _config!.regions.firstWhere(
      (r) => r.id == id,
      orElse: () => Region(
        id: id,
        purpose: '',
        type: '',
        zIndex: 0,
      ),
    );
  }

  Rect? _getScaledBounds(Region? region) {
    if (region == null || region.bounds == null) return null;
    final bounds = region.bounds!;
    return Rect.fromLTWH(
      bounds.x * _scaleFactor,
      bounds.y * _scaleFactor,
      bounds.width * _scaleFactor,
      bounds.height * _scaleFactor,
    );
  }

  double _getFontSize(Rect? bounds, {double fillRatio = 0.8}) {
    if (bounds == null) return 16.0;
    final minDimension =
        bounds.width < bounds.height ? bounds.width : bounds.height;
    return minDimension * fillRatio;
  }

  TextStyle _getTextStyle(
    CardTypeConfig config, {
    double? fontSize,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    final color = Color(
      int.parse(config.textColor.replaceFirst('#', '0xFF')),
    );

    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5),
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardType = widget.cardType ?? _getCardType();
    final cardConfig = _config?.cardTypeConfig[cardType.name] ??
        CardTypeConfig(
            backgroundImage: 'assets/cards/bronze_base.png',
            textColor: '#000000');

    return LayoutBuilder(
      builder: (context, constraints) {
        _scaleFactor = constraints.maxWidth / _config!.dimensions.width;

        return GestureDetector(
          onTap: widget.onClick,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: constraints.maxWidth,
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  // Card background
                  Positioned.fill(
                    child: Image.asset(
                      widget.isGuest
                          ? 'assets/cards/guest.png'
                          : cardConfig.backgroundImage,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Club logo
                  if (!widget.isGuest &&
                      widget.member.club?.imageUrl != null) ...[
                    _buildRegionWidget(
                      'club-logo',
                      (rect) => ClipOval(
                        child: Image.network(
                          widget.member.club!.imageUrl!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],

                  // Player rating
                  if (widget.lastMatchRating != null) ...[
                    _buildRegionWidget(
                      'player-rating',
                      (rect) => Text(
                        widget.lastMatchRating!.toStringAsFixed(1),
                        style: _getTextStyle(
                          cardConfig,
                          fontSize: _getFontSize(rect, fillRatio: 0.75),
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],

                  // Jersey number
                  if (widget.member.jerseyNumber > 0) ...[
                    _buildRegionWidget(
                      'jersey-number',
                      (rect) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/cards/jersey.png',
                            color: cardConfig.textColor == '#FFD700'
                                ? Colors.white
                                : Colors.black,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            '${widget.member.jerseyNumber}',
                            style: _getTextStyle(
                              cardConfig,
                              fontSize: _getFontSize(rect, fillRatio: 0.35),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Primary role
                  _buildRegionWidget(
                    'primary-role',
                    (rect) => Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(int.parse(
                              cardConfig.textColor.replaceFirst('#', '0xFF'))),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        color: cardConfig.textColor == '#FFD700'
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.2),
                      ),
                      child: Text(
                        _roleAbbreviations[widget.member.primaryRole] ?? '',
                        style: _getTextStyle(
                          cardConfig,
                          fontSize: _getFontSize(rect, fillRatio: 0.65),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  // Secondary roles
                  if (widget.member.secondaryRoles.isNotEmpty) ...[
                    _buildRegionWidget(
                      'secondary-roles',
                      (rect) => Text(
                        widget.member.secondaryRoles
                            .take(2)
                            .map((r) => _roleAbbreviations[r] ?? '')
                            .join(', '),
                        style: _getTextStyle(
                          cardConfig,
                          fontSize: _getFontSize(rect, fillRatio: 0.6),
                          fontWeight: FontWeight.w700,
                        ).copyWith(
                          color: Color(int.parse(cardConfig.textColor
                                  .replaceFirst('#', '0xFF')))
                              .withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],

                  // Player symbol
                  if (widget.member.symbol.isNotEmpty) ...[
                    _buildRegionWidget(
                      'player-symbol',
                      (rect) => Text(
                        widget.member.symbol,
                        style: _getTextStyle(
                          cardConfig,
                          fontSize: _getFontSize(rect, fillRatio: 0.7),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],

                  // Privilege icon
                  if (!widget.isGuest) ...[
                    _buildRegionWidget(
                      'privilege-icon',
                      (rect) => Image.asset(
                        'assets/privileges/${widget.member.privileges.name.toLowerCase()}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],

                  // Player photo
                  if (!widget.isGuest) ...[
                    _buildRegionWidget(
                      'player-photo',
                      (rect) => ClipRect(
                        child: widget.member.user?.imageUrl != null
                            ? Image.network(
                                widget.member.user!.imageUrl!,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )
                            : Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    _getInitials(),
                                    style: _getTextStyle(
                                      cardConfig,
                                      fontSize:
                                          _getFontSize(rect, fillRatio: 0.5),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],

                  // Player name
                  _buildRegionWidget(
                    'player-name',
                    (rect) => Text(
                      _getDisplayName().toUpperCase(),
                      style: _getTextStyle(
                        cardConfig,
                        fontSize: _getFontSize(rect, fillRatio: 0.55),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRegionWidget(
      String regionId, Widget Function(Rect rect) builder) {
    final region = _findRegion(regionId);
    final rect = _getScaledBounds(region);

    if (rect == null) return const SizedBox.shrink();

    return Positioned(
      left: rect.left,
      top: rect.top,
      width: rect.width,
      height: rect.height,
      child: builder(rect),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final config = await CardSpacesConfig.load();
    setState(() {
      _config = config;
    });
  }
}
