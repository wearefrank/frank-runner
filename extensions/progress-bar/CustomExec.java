package org.apache.tools.ant.taskdefs;

import java.io.FileDescriptor;
import java.io.FileOutputStream;

import org.apache.tools.ant.BuildException;

public class CustomExec extends ExecTask {

    @Override
    protected Execute prepareExec() throws BuildException {

        Execute exe = super.prepareExec();

        exe.setStreamHandler(
            new PumpStreamHandler(
                new FileOutputStream(FileDescriptor.out),
                new FileOutputStream(FileDescriptor.err)
            )
        );

        return exe;
    }
}