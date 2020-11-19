*** Settings ***
Documentation                  Check & Validate OS and PSB packages
Library                        SSHLibrary
Suite Teardown                 Close All Connections


*** Variables ***
@{ALLHOSTS}=        10.189.153.69  10.189.153.70  10.189.153.71  10.189.153.72  10.189.153.73  10.189.153.74  10.189.153.75
@{CONTROLLERS}=     10.189.153.69  10.189.153.70  10.189.153.71
@{COMPUTES}=        10.189.153.72  10.189.153.73  10.189.153.74  10.189.153.75
${USERNAME}         root
${PASSWORD}         STRANGE-EXAMPLE-neither

*** Test Cases ***
Validate OS release (CentOS Linux release 7.8.2003) on all nodes
    [Documentation]			Validate OS release on all nodes
    FOR  ${HOST}  IN  @{ALLHOSTS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  cat /etc/centos-release
        Should Be Equal         ${output}  CentOS Linux release 7.8.2003 (Core)
        close connection
    END

Validate Kernel release (3.10.0-1127.13.1.el7.x86_64) on all nodes
    [Documentation]			Validate Kernel release on all nodes
    FOR  ${HOST}  IN  @{ALLHOSTS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  uname -r
        Should Be Equal         ${output}  3.10.0-1127.13.1.el7.x86_64
        close connection
    END

Validate Nova Version (14.0.8) on all nodes
    [Documentation]			Validate Nova Version on all nodes
    FOR  ${HOST}  IN  @{ALLHOSTS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  nova-manage --version  return_stderr=True  return_stdout=False
        Should Be Equal         ${output}  14.0.8
        close connection
    END

Validate Glance Version (13.0.0) on Controller nodes
    [Documentation]			Validate nova Version on Controller nodes
    FOR  ${HOST}  IN  @{CONTROLLERS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  glance-manage --version   return_stderr=True  return_stdout=False
        Run Keyword And Continue On Failure     should contain         ${output}  13.0.0
        close connection
    END

Validate Cinder Version (9.1.4) on Controller nodes
    [Documentation]			Validate Cinder Version on Controller nodes
    FOR  ${HOST}  IN  @{CONTROLLERS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  cinder-manage --version   return_stderr=True  return_stdout=False
        Run Keyword And Continue On Failure     should contain         ${output}  9.1.4
        close connection
    END

Validate Neutron Version (9.4.1) on all nodes
    [Documentation]			Validate Neutron Version on all nodes
    FOR  ${HOST}  IN  @{ALLHOSTS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  neutron-server --version   return_stderr=True  return_stdout=False
        Run Keyword And Continue On Failure     should contain         ${output}  9.4.1
        close connection
    END

Validate Aodh Version (3.0.4) on Controller nodes
    [Documentation]			Validate Aodh Version on Controller nodes
    FOR  ${HOST}  IN  @{CONTROLLERS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  yum list installed | grep -i aodh | grep -i common
        Run Keyword And Continue On Failure     should contain         ${output}  3.0.4
        close connection
    END

Validate Gnocchi Version (3.0.15) on Controller nodes
    [Documentation]			Validate Gnocchi Version on Controller nodes
    FOR  ${HOST}  IN  @{CONTROLLERS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command  yum list installed | grep -i common | grep -i gnocchi
        Run Keyword And Continue On Failure     should contain         ${output}  3.0.15
        close connection
    END

Validate Heat Version (7.0.6) on Controller nodes
    [Documentation]			Validate Heat Version on Controller nodes
    FOR  ${HOST}  IN  @{CONTROLLERS}
        open connection         ${HOST}
        login                   ${USERNAME}  ${PASSWORD}  False  True
        ${output}=              execute command    heat-manage --version   return_stderr=True  return_stdout=False
        Should Be Equal         ${output}  7.0.6
        close connection
    END


*** Keywords ***

