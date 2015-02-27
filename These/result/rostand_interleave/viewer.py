#!/bin/python

import sys
from PyQt5 import QtCore, QtGui, QtWidgets
#from PyQt4 import QtGui, QtCore
from numpy import arange, sin, pi
from matplotlib.backends import qt_compat
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import random
import pickle

# 30_1_0_3_Da2a_Fa6a_6
cases = {
    "matrix"  : ["spe10", "30", "80", "100"],
    "npri"    : ["1", "3", "8"],
    "lfill"   : ["0"],
    "taggre3" : ["", "3"],
    "taggreD" : ["", "D(2)", "D(4)", "D(8)", "D(12)"],
    "taggreF" : ["", "F(6)", "F(12)", "F(18)", "F(24)", "F(36)"],
    "thread"  : ["1", "2", "4", "8", "12"]
}
cases_order = ["matrix", "npri",  "lfill", "taggre3", "taggreD", "taggreF", "thread"]



factorize = pickle.load( open("factorize.pick", "rb") )
setup = pickle.load( open("setup.pick", "rb") )
precond = pickle.load( open("precond.pick", "rb") )
solve = pickle.load( open("solve.pick", "rb") )
all_tests = {
    "factorize" : factorize,
    "setup"     : setup,
    "precond"   : precond,
    "solve"     : solve
}
test_select = "factorize"

gxaxis = "matrix"
speedup = False
selectors = {}
def get_time(chaine):
    if all_tests[test_select][chaine] == None:
        return 0
    else:
        return all_tests[test_select][chaine]

def addT(i, i_max, st, all_tests, over):
    liste = selectors[cases_order[i]].getList()
    over_save = over
    for k in liste:
        k_printable = k.replace("(", "a").replace(")","a")
        if i == 0 :
            st2 = k_printable
        else:
            st2 = st + "_" + k_printable

        if cases_order[i] == gxaxis:
            over = st
            if gxaxis == "matrix":
                over = "M_" + over_save
        else:
            over = over_save + "_" + k_printable

        if i+1 >= i_max:
            if all_tests.get(over) == None:
                all_tests[over] = []
            if k is "":
                all_tests[over].append(get_time(st2[:-1]))
            else :
                all_tests[over].append(get_time(st2))
        else:
            addT(i+1, i_max, st2, all_tests, over)

def update_tests():
    for k in cases_order:
        if len(selectors[k].getList()) == 0:
            print("Need at least on element in %s" % k)
            return None
    all_tests = {}
    addT(0, len(cases_order), "", all_tests, "")
    return all_tests


class MyMplCanvas(FigureCanvas):
    """Ultimately, this is a QWidget (as well as a FigureCanvasAgg, etc.)."""
    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.axes = fig.add_subplot(111)
        # We don't want the axes cleared every time plot() is called
        self.axes.hold(True)

        self.compute_initial_figure()

        #
        FigureCanvas.__init__(self, fig)
        self.setParent(parent)

        FigureCanvas.setSizePolicy(self,
                                   QtWidgets.QSizePolicy.Expanding,
                                   QtWidgets.QSizePolicy.Expanding)
        FigureCanvas.updateGeometry(self)

    def compute_initial_figure(self):
        pass


class MyStaticMplCanvas(MyMplCanvas):
    """Simple canvas with a sine plot."""
    def compute_initial_figure(self):
        t = arange(0.0, 3.0, 0.01)
        s = sin(2*pi*t)
        self.axes.plot(t, s)

need_update=True
class MyDynamicMplCanvas(MyMplCanvas):
    """A canvas that updates itself every second with a new plot."""
    def __init__(self, *args, **kwargs):
        MyMplCanvas.__init__(self, *args, **kwargs)
        timer = QtCore.QTimer(self)
        timer.timeout.connect(self.update_figure)
        timer.start(1000)

    def compute_initial_figure(self):
        self.axes.plot([0, 1, 2, 3], [1, 1, 1, 1], 'r')

    def update_figure(self):
        global need_update
        if not need_update:
            return
        need_update=False

        self.axes.clear()
        all_times = update_tests()
        if all_times == None:
            self.draw()
            return

        x = selectors[gxaxis].getList()
        xx=[]
        if gxaxis == "thread" or gxaxis == "npri" or gxaxis == "lfill":
            xx = selectors[gxaxis].getList()
        else:
            i=0
            for l in x:
                xx.append(str(i))
                i+=1

        print("++++++++++++++++++++++++++++++++")
        sys.stdout.write("\t")
        for k in all_times:
            if not all_times[k] == []:
                if speedup:
                    for val in range(1,len(all_times[k])):
                        all_times[k][val] = all_times[k][0] / all_times[k][val]
                    all_times[k][0] = 1
                sys.stdout.write(str(k) + "\t")
                self.axes.plot(xx, all_times[k], label=str(k))
        sys.stdout.write("\n")


        for i in range(len(xx)):
            sys.stdout.write(xx[i])
            sys.stdout.write("\t")
            for k in all_times:
                try :
                    sys.stdout.write(str(all_times[k][i])[:15])
                except IndexError as e:
                    raise
                sys.stdout.write("\t")
                if len(str(k)) > 15:
                    sys.stdout.write("\t")
            sys.stdout.write("\n")


        self.axes.legend()
        self.draw()







cases_a= []
for k in cases_order:
    print(k)
    cases_a.append(cases[k])

class TestSelector(QtWidgets.QWidget):

    def __init__(self, testName):
        super(TestSelector, self).__init__()
        self.testName = testName
        self.initUI()

    def initUI(self):
        self.vbox = QtWidgets.QVBoxLayout(self)

        self.vbox.addWidget(QtWidgets.QLabel(self.testName + " : "))

        self.all_button = QtWidgets.QToolButton(self)
        self.all_button.setText("All")
        self.all_button.clicked.connect(self.allToTrue)
        self.vbox.addWidget(self.all_button)

        self.clear_button = QtWidgets.QToolButton(self)
        self.clear_button.setText("Clear")
        self.clear_button.clicked.connect(self.clearToTrue)
        self.vbox.addWidget(self.clear_button)

        self.cbs = []
        for name in cases[self.testName]:
            cb = QtWidgets.QCheckBox(name, self)
            cb.clicked.connect(self.needUp)
            self.vbox.addWidget(cb)
            self.cbs.append ((name, cb))
            if cases[self.testName][0] == name:
                cb.setChecked(True)

        self.vbox.addSpacerItem(QtWidgets.QSpacerItem(1, 1, vPolicy = QtWidgets.QSizePolicy.Expanding))
        self.show()

    def allToTrue(self) :
        for i in self.cbs:
            i[1].setChecked(True)

    def clearToTrue(self) :
        for i in self.cbs:
            i[1].setChecked(False)

    def getList(self):
        liste=[]
        for i in self.cbs:
            if i[1].isChecked():
                liste.append(i[0])
        return liste

    def needUp(self):
        global need_update
        need_update=True


class XAxis(QtWidgets.QWidget):

    def __init__(self):
        super(XAxis, self).__init__()
        self.initUI()

    def initUI(self):
        self.hbox = QtWidgets.QHBoxLayout(self)
        self.hbox.addWidget(QtWidgets.QLabel("X Axis :"))
        self.cb = QtWidgets.QComboBox(self)
        self.cb.activated[str].connect(self.setAxis)
        self.hbox.addWidget(self.cb)


        self.hbox.addWidget(QtWidgets.QLabel("Test type :"))
        self.cb_test = QtWidgets.QComboBox(self)
        self.cb_test.activated[str].connect(self.setTest)
        self.hbox.addWidget(self.cb_test)
        self.cb_test.addItem("factorize")
        self.cb_test.addItem("setup")
        self.cb_test.addItem("precond")
        self.cb_test.addItem("solve")


        self.cb_speedup = QtWidgets.QCheckBox("Speedup")
        self.hbox.addWidget(self.cb_speedup)
        self.cb_speedup.clicked[bool].connect(self.setSpeedup)


        for k in cases_order:
            self.cb.addItem(k)

        self.hbox.addSpacerItem(QtWidgets.QSpacerItem(1, 1, hPolicy = QtWidgets.QSizePolicy.Expanding))

    def setAxis(self, text):
        global gxaxis
        global need_update
        gxaxis = text
        need_update = True

    def setTest(self, text):
        global test_select
        global need_update
        test_select = text
        need_update = True

    def setSpeedup(self, value):
        global speedup
        global need_update
        speedup = value
        need_update = True

def main():

    app = QtWidgets.QApplication(sys.argv)

    w = QtWidgets.QWidget()
    w.setWindowTitle('Taggre result viewer')
    vbox = QtWidgets.QVBoxLayout(w)
    vbox.addWidget(XAxis())

    hbox = QtWidgets.QHBoxLayout(w)
    for k in cases_order:
        selectors[k] = TestSelector(k)
        hbox.addWidget(selectors[k])
    vbox.addLayout(hbox)

    sc = MyDynamicMplCanvas(w, width=5, height=4, dpi=100)
    vbox.addWidget(sc)

    w.setLayout(vbox)
    w.show()

    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
