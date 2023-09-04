<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'database_name_here' );

/** Database username */
define( 'DB_USER', 'username_here' );

/** Database password */
define( 'DB_PASSWORD', 'password_here' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
// define( 'AUTH_KEY',         'put your unique phrase here' );
// define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
// define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
// define( 'NONCE_KEY',        'put your unique phrase here' );
// define( 'AUTH_SALT',        'put your unique phrase here' );
// define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
// define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
// define( 'NONCE_SALT',       'put your unique phrase here' );

define('AUTH_KEY',         'I= P~CJJ+5)ck=b_b$SO6Omox)+e>Zpzl,9zecqsd[T%pG{}pj,Z:X/?kvVkGx3)');
define('SECURE_AUTH_KEY',  'VF}Y]&G .8xVH`4`o:3I|pAvymvGS|4wqfjC|<k+^<&^-G>b6u-N)?yDDCJjxX/V');
define('LOGGED_IN_KEY',    'ak>qFPd&f>7DPTtK)A5JkjyK!03h-htu}y$|OgOp.-7,OYxGG#Up%zs/&X0YxH+n');
define('NONCE_KEY',        'MX7U(4$-@^0Y!e)D*_R7l#]}v:?B2wKq)kHlv~N^D<&1R[}*;_NJ!YX9*&+O7gKR');
define('AUTH_SALT',        'asNzrC.i0+OA{ro)VGhg308)nd7g[^pBu`|Wnp^E6kMg+~,e5Yed?`m`$+9PyreE');
define('SECURE_AUTH_SALT', 'Nx ~:^?ey-62oZC#~{)sBRStC}/|*yN;HwwZS<W_Z^@w<[Enyj!q-:R4^r| %TS1');
define('LOGGED_IN_SALT',   '-aUQ@iyPdf7^IH+p~^f[1<(,|-4C43>hu{ g$dakATmG2AH-:8P6X#Pg#Y`cb^qu');
define('NONCE_SALT',       'h~PVW+*k/k?NV-cL4+U1.Re28C0w!0=++->{c#6Z@}V*{|W)K+x(KxI;46#R#s=H');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
