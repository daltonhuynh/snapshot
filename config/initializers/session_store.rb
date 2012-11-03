require 'action_dispatch/middleware/session/dalli_store'
Snapshot::Application.config.session_store :dalli_store,
                                        :namespace => 'sessions',
                                        :key => 'REPLACE_ME',
                                        :compression => true
