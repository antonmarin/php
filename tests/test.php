<?php

echo json_encode(
    [
        'xdebug loaded' => extension_loaded('xdebug'),
        'session cookies enabled' => ini_get('session.use_cookies')
    ]
);
